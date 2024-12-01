import 'dart:io';

import 'package:app/components/pricing_widgets/pricing_container.dart';
import 'package:app/pages/pricing_page/pricing_view_model.dart';
import 'package:app/utils/state/pricing_provider_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PricingMobileView extends HookConsumerWidget {
  const PricingMobileView({
    Key? key,
    required this.pricingViewModel,
  }) : super(key: key);

  final PricingViewModel pricingViewModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get all pricing data from the provider
    Map<String, dynamic> getAllPricingData =
        ref.watch(pricingDataProvider.notifier).getPricingData();

    // Extract pricing data for Little Masters, Emerging Market Leaders, Large Cap Focus
    List<dynamic> littleMastersData =
        List.from(getAllPricingData['setLittleMasterData'] ?? []);
    List<dynamic> emergingMarketLeadersData =
        List.from(getAllPricingData['setEmergingMarketLeadersData'] ?? []);
    List<dynamic> largeCapFocusData =
        List.from(getAllPricingData['setLargeCapFocusData'] ?? []);
    List<dynamic> stocksOnTheMoveData =
        List.from(getAllPricingData['setStocksOnTheMoveData'] ?? []);

    // Helper function to build options with discounted prices
    List<String> buildOptions(List<dynamic> data) {
      List<String> options = [];
      // Default option (Select a Plan)
      options.add('Select a Plan (inclusive of GST)');

      // Add the custom 6 Months option
      options.add('6 Months - Rs. 12500');

      // Add other options based on dynamic pricing data
      for (var item in data) {
        if (item is Map<String, dynamic>) {
          String duration = item['PDuration']?.toString() ?? 'Unknown Duration';
          String originalAmount = item['PAmount']?.toString() ?? '0.0';
          String discountedAmount =
              '20000'; // Add a fixed discounted price here or replace dynamically

          // Add the option with both original and discounted prices
          options.add(
            '$duration - Rs. $originalAmount  Rs. $discountedAmount', // Added space between prices
          );
        }
      }
      return options;
    }

    // Generate options for each card based on their respective data
    final littleMastersOptions = buildOptions(littleMastersData);
    final emergingMarketLeadersOptions =
        buildOptions(emergingMarketLeadersData);
    final largeCapFocusOptions = buildOptions(largeCapFocusData);
    final stocksOnTheMoveOptions = buildOptions(stocksOnTheMoveData);

    // Using hooks for state management
    final selectedOptions = useState<List<Map<String, dynamic>>>([]);
    final totalPrice = useState<double>(0.0);
    final discountAmount = useState<double>(0.0);
    final discountApplied = useState<bool>(false);

    // Function to get original price and discounted price from the option string
    double getOriginalPrice(String option) {
      // Check if the option is "6 Months - Rs. 12500"
      if (option == '6 Months - Rs. 12500') {
        return 12500.0;
      }

      var parts = option.split(' - Rs. ');
      if (parts.length == 2) {
        var discountedParts = parts[1].split('  Rs. ');
        if (discountedParts.length == 2) {
          return double.tryParse(discountedParts[0]) ?? 0.0;
        }
      }
      return 0.0;
    }

    double getDiscountedPrice(String option) {
      // Check if the option is "6 Months - Rs. 12500"
      if (option == '6 Months - Rs. 12500') {
        return 12500.0;
      }

      var parts = option.split(' - Rs. ');
      if (parts.length == 2) {
        var discountedParts = parts[1].split('  Rs. ');
        if (discountedParts.length == 2) {
          return double.tryParse(discountedParts[1]) ?? 0.0;
        }
      }
      return 0.0;
    }

    // Update the selected option and pricing data
    void updatePricing(String selected, String cardName, int optionNumber) {
      // Update the selection list
      List<Map<String, dynamic>> newSelections =
          List.from(selectedOptions.value);

      // Check if the card is already in the selection list
      bool cardExists = false;
      int cardIndex = -1;
      for (int i = 0; i < newSelections.length; i++) {
        if (newSelections[i]['card'] == cardName) {
          cardExists = true;
          cardIndex = i;
          break;
        }
      }

      // If card exists, update the selected option number
      if (cardExists) {
        newSelections[cardIndex]['option'] = optionNumber;
      } else {
        // If the card doesn't exist, add it to the list
        newSelections.add({'card': cardName, 'option': optionNumber});
      }

      // Calculate the total price and apply discount conditions
      double priceToRemove = 0.0;
      double priceToAdd = 0.0;
      int validOptionCount = 0;

      totalPrice.value = 0.0;
      discountApplied.value = false;

      // Loop through the selection list to calculate total price
      for (var selection in newSelections) {
        String card = selection['card'];
        int optionNum = selection['option'];

        // Get the selected option price based on the card and option number
        String selectedOption = '';
        switch (card) {
          case "Little Masters":
            selectedOption = littleMastersOptions[optionNum - 1];
            break;
          case "Emerging Market Leaders":
            selectedOption = emergingMarketLeadersOptions[optionNum - 1];
            break;
          case "Large Cap Focus":
            selectedOption = largeCapFocusOptions[optionNum - 1];
            break;
          case "Stocks On the Move":
            selectedOption = stocksOnTheMoveOptions[optionNum - 1];
            break;
        }

        double originalPrice = getOriginalPrice(selectedOption);
        double discountedPrice = getDiscountedPrice(selectedOption);

        // Add the appropriate price (original or discounted) to the total price
        if (selectedOption != 'Select a Plan (inclusive of GST)') {
          totalPrice.value += discountedPrice;
          validOptionCount++;
        }

        // Track the price of option before changing
        if (optionNum != 1) {
          priceToRemove = priceToAdd;
          priceToAdd = originalPrice > 0 ? originalPrice : discountedPrice;
        }
      }

      // If there are more than 1 valid selections, apply 20% discount
      if (validOptionCount > 1) {
        discountApplied.value = true;
        discountAmount.value = totalPrice.value * 0.2;
        totalPrice.value *= 0.8;
      } else {
        // Revert 20% discount if there's only one option
        totalPrice.value += priceToRemove;
      }

      // Update the state of selected options
      selectedOptions.value = newSelections;
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 237, 237),
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                exit(0);
              },
            ),
            const SizedBox(width: 8),
            const Text('Pricing'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.support_agent,
              size: 30,
            ),
            onPressed: () {
              Fluttertoast.showToast(
                msg: 'Support Agent Coming Soon',
                backgroundColor: Colors.blue,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                fontSize: 16.0,
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Main content (scrollable column of pricing containers)
          Positioned.fill(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    PricingContainer(
                      icon: Icons.diamond,
                      title: "Little Masters",
                      subtitle: "Small cap",
                      description:
                          "Invest in up-trending Smallcap stocks screened through MILARS strategy to generate wealth.",
                      options: littleMastersOptions,
                      onSelectOption: (selected) => updatePricing(
                          selected,
                          "Little Masters",
                          littleMastersOptions.indexOf(selected) + 1),
                    ),
                    const SizedBox(height: 16),
                    PricingContainer(
                      icon: Icons.military_tech,
                      title: "Emerging Market Leaders",
                      subtitle: "Mid cap",
                      description:
                          "Generate wealth by riding momentum in Midcap stocks screened through MILARS strategy.",
                      options: emergingMarketLeadersOptions,
                      onSelectOption: (selected) => updatePricing(
                          selected,
                          "Emerging Market Leaders",
                          emergingMarketLeadersOptions.indexOf(selected) + 1),
                    ),
                    const SizedBox(height: 16),
                    PricingContainer(
                      icon: Icons.adjust,
                      title: "Large Cap Focus",
                      subtitle: "Large cap",
                      description:
                          "Achieve stable growth in your portfolio by investing in Bluechip stocks passed through MILARS strategy.",
                      options: largeCapFocusOptions,
                      onSelectOption: (selected) => updatePricing(
                          selected,
                          "Large Cap Focus",
                          largeCapFocusOptions.indexOf(selected) + 1),
                    ),
                    const SizedBox(height: 16),
                    PricingContainer(
                      icon: Icons.money,
                      title: "Stocks On the Move",
                      subtitle: "Flexi Cap",
                      description:
                          "Seize opportunities in stocks that are experiencing high volatility and significant movements.",
                      options: stocksOnTheMoveOptions,
                      onSelectOption: (selected) => updatePricing(
                          selected,
                          "Stocks On the Move",
                          stocksOnTheMoveOptions.indexOf(selected) + 1),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Discount message
          if (discountApplied.value)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(5.0),
                color: const Color.fromARGB(255, 5, 126, 9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'You will save Rs. ${discountAmount.value.toStringAsFixed(0)} on this plan',
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          // Total price at the bottom
          if (totalPrice.value > 0.0)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(171, 1, 1, 0),
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    'Rs. ${totalPrice.value.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const TextSpan(text: '\n'),
                              const TextSpan(
                                  text: 'Inclusive GST',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black38)),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Fluttertoast.showToast(
                              msg: 'Payment Method Coming Soon',
                              backgroundColor: Colors.blue,
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 5,
                              fontSize: 16.0,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(120, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: const Color(0xFF18398E)),
                          child: const Text(
                            "Proceed for Payment",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
