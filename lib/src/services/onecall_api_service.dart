import 'package:dio/dio.dart';
import 'package:ethio_weather/src/services/dio_client.dart';

import '../config.dart';
import '../models/lat_long.dart';
import '../models/open_weather_map.dart';

class OneCallApiService {
  final _apiOneCall = DioClient.create();

  Future<OpenWeatherMap> fetchWeatherData(LatLong latLong) async {
    try {
      Options _options = Options(
        headers: {"Content-Type": "application/json"},
      );

      Response response = await _apiOneCall.get('/data/2.5/onecall',
          queryParameters: {
            'lat': latLong.latitude.toString(),
            'lon': latLong.longitude.toString(),
            'appid': Config.appId,
            'units': 'metric',
            'lang': 'en'
          },
          options: _options);

      if (response.statusCode == 200) {
        return OpenWeatherMap.fromJson(response.data);
      }
      return Future.error('Failed to Open Weather data');
    } on DioError catch (e) {
      throw Exception("DioError: Failed to Open Weather data");
    }
  }
}
