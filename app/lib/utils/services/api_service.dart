import 'package:dio/dio.dart';

Duration? connectTimeout = const Duration(seconds: 30);
Duration? sendTimeout = const Duration(seconds: 300);
Duration? receiveTimeout = const Duration(seconds: 300);

class APIService {
  static Dio get dataAPIGateway {
    return Dio(BaseOptions(
      baseUrl: 'https://www.stockaxis.com/webservices/android',
      connectTimeout: connectTimeout,
      sendTimeout: sendTimeout,
      receiveTimeout: receiveTimeout,
      followRedirects: true,
    ));
  }
}
