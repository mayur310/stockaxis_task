import 'dart:convert';

import 'package:app/utils/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PricingAPIs {
  //Little Masters
  static Future<List<Map<String, dynamic>>> getLittleMasterData() async {
    try {
      Response<String> getResponseLittleMaster = await APIService.dataAPIGateway
          .get(
              '/index.aspx?action=search&activity=PricingV2&CID=984493&PKGName=LM');
      // Get the raw response body
      String rawResponse = getResponseLittleMaster.data!;

      // Find the first complete JSON object in the response
      RegExp jsonRegex = RegExp(r'\{.*\}', multiLine: true, dotAll: true);
      String? jsonString = jsonRegex.firstMatch(rawResponse)?.group(0);

      if (jsonString == null) {
        Fluttertoast.showToast(
          msg: 'Error in fetching Little Master. Retry',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 10,
          fontSize: 16.0,
        );
        return [];
      }

      Map<String, dynamic> jsonDecodeResponseLittleMaster =
          jsonDecode(jsonString) as Map<String, dynamic>;

      List<Map<String, dynamic>> returnDataList =
          (jsonDecodeResponseLittleMaster['data'] as List)
              .cast<Map<String, dynamic>>();
      return returnDataList;
    } catch (errorHandle) {
      Fluttertoast.showToast(
        msg: 'Error in fetching Little Master. Retry',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 10,
        fontSize: 16.0,
      );
      return [];
    }
  }

  // //Emerging Market Leaders
  static Future<List<Map<String, dynamic>>>
      getEmergingMarketLeadersData() async {
    try {
      Response<String> getResponseEmergingMarketLeaders =
          await APIService.dataAPIGateway.get(
              '/index.aspx?action=search&activity=PricingV2&CID=984493&PKGName=EML');
      // Get the raw response body
      String rawResponse = getResponseEmergingMarketLeaders.data!;

      // Find the first complete JSON object in the response
      RegExp jsonRegex = RegExp(r'\{.*\}', multiLine: true, dotAll: true);
      String? jsonString = jsonRegex.firstMatch(rawResponse)?.group(0);

      if (jsonString == null) {
        Fluttertoast.showToast(
          msg: 'Error in fetching Emerging Market Leaders. Retry',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 10,
          fontSize: 16.0,
        );
        return [];
      }

      Map<String, dynamic> jsonDecodeResponseEmergingMarketLeaders =
          jsonDecode(jsonString) as Map<String, dynamic>;

      List<Map<String, dynamic>> returnDataList =
          (jsonDecodeResponseEmergingMarketLeaders['data'] as List)
              .cast<Map<String, dynamic>>();

      return returnDataList;
    } catch (errorHandle) {
      Fluttertoast.showToast(
        msg: 'Error in fetching Emerging Market Leaders. Retry',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 10,
        fontSize: 16.0,
      );
      return [];
    }
  }

  //Large Cap Focus
  static Future<List<Map<String, dynamic>>> getLargeCapFocusData() async {
    try {
      // Send GET request
      Response<String> getResponseLargeCapFocus =
          await APIService.dataAPIGateway.get(
              '/index.aspx?action=search&activity=PricingV2&CID=984493&PKGName=LCF');

      // Get the raw response body
      String rawResponse = getResponseLargeCapFocus.data!;

      // Find the first complete JSON object in the response
      RegExp jsonRegex = RegExp(r'\{.*\}', multiLine: true, dotAll: true);
      String? jsonString = jsonRegex.firstMatch(rawResponse)?.group(0);

      if (jsonString == null) {
        Fluttertoast.showToast(
          msg: 'Error in fetching Large Cap Focus. Retry',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 10,
          fontSize: 16.0,
        );
        return [];
      }

      // Decode the JSON
      Map<String, dynamic> jsonDecodeResponseLargeCapFocus =
          jsonDecode(jsonString) as Map<String, dynamic>;

      List<Map<String, dynamic>> returnDataList =
          (jsonDecodeResponseLargeCapFocus['data'] as List)
              .cast<Map<String, dynamic>>();

      // Return the data list
      return returnDataList;
    } catch (errorHandle) {
      Fluttertoast.showToast(
        msg: 'Error in fetching Large Cap Focus. Retry',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 10,
        fontSize: 16.0,
      );
      return [];
    }
  }
}
