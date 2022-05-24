import 'package:dio/dio.dart';
import 'package:ethio_weather/src/config.dart';

class DioClient {
  static Dio create() {
    final dio = Dio();
    // Set default configs
    dio.options.baseUrl = Config.apiBaseUrl;

    return dio;
  }
}
