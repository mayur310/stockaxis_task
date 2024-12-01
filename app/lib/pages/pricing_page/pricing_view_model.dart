import 'package:app/apis/pricing_apis/pricing_apis.dart';
import 'package:app/utils/state/pricing_provider_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PricingViewModel {
  final Key? key;
  final WidgetRef ref;

  PricingViewModel({this.key, required this.ref});

  static Future<PricingViewModel> initalizePricingDataAPIs(
      {required WidgetRef ref}) async {
    //Little Masters
    List<Map<String, dynamic>> setLittleMasterData =
        await PricingAPIs.getLittleMasterData();
    //Emerging Market Leaders
    List<Map<String, dynamic>> setEmergingMarketLeadersData =
        await PricingAPIs.getEmergingMarketLeadersData();
    //Large Cap Focus
    List<Map<String, dynamic>> setLargeCapFocusData =
        await PricingAPIs.getLargeCapFocusData();

    // setting the Pricing data in providers
    ref.read(pricingDataProvider.notifier).setPricingData({
      'setLittleMasterData': setLittleMasterData,
      'setEmergingMarketLeadersData': setEmergingMarketLeadersData,
      'setLargeCapFocusData': setLargeCapFocusData
    });
    return PricingViewModel(ref: ref);
  }
}
