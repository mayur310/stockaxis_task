import 'package:hooks_riverpod/hooks_riverpod.dart';

// Pricing state management handling
class PricingDataNotifier extends StateNotifier<Map<String, dynamic>> {
  final Ref ref;
  PricingDataNotifier(this.ref) : super({});

  // setting all pricing data
  void setPricingData(Map<String, dynamic> pricingData) {
    state = pricingData;
  }

  // getting all the pricing data
  Map<String, dynamic> getPricingData() {
    return state;
  }

  //Little Masters
  List<Map<String, dynamic>> getLittleMasterData() {
    return (state['setLittleMasterData'] as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .toList();
  }

  //Emerging Market Leaders
  List<Map<String, dynamic>> getEmergingMarketLeadersData() {
    return (state['setEmergingMarketLeadersData'] as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .toList();
  }

  //Large Cap Focus
  List<Map<String, dynamic>> getLargeCapFocusData() {
    return (state['setLargeCapFocusData'] as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .toList();
  }

  // updating in all pages.
  void updatePricingData(String key, dynamic data) {
    Map<String, dynamic> tempState = {...state};
    tempState[key] = data;
    state = tempState;
  }
}

final pricingDataProvider =
    StateNotifierProvider<PricingDataNotifier, Map<String, dynamic>>(
        (ref) => PricingDataNotifier(ref));
