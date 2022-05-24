import 'package:ethio_weather/src/models/lat_long.dart';
import 'package:ethio_weather/src/services/onecall_api_service.dart';
import 'package:flutter/cupertino.dart';

import '../models/open_weather_map.dart';

class OneCallWeatherNotifier extends ChangeNotifier {
  OpenWeatherMap? _weather;
  OpenWeatherMap? get weather => _weather;

  final LatLong _latLong;

  OneCallWeatherNotifier(this._latLong) {
    _getWeather(_latLong);
  }

  _getWeather(LatLong latLong) async {
    _weather = await OneCallApiService().fetchWeatherData(latLong);
    notifyListeners();
  }

  reloadWeather() {
    _getWeather(_latLong);
  }
}
