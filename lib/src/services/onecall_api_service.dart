import 'dart:convert';

import 'package:http/http.dart' show get;

import '../models/open_weather_map.dart';

class OneCallApiService {
  Future<OpenWeatherMap> fetchWeatherData(String url) async {
    var httpsOneCallUri = Uri.parse(url);
    final response = await get(httpsOneCallUri, headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return OpenWeatherMap.fromJson(jsonData);
    }
    return Future.error('Failed to Open Weather data');
  }
}
