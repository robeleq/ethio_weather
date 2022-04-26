import 'package:ethio_weather/src/models/lat_lng.dart';
import 'package:ethio_weather/src/services/onecall_api_service.dart';
import 'package:flutter/cupertino.dart';

import '../config.dart';
import '../models/open_weather_map.dart';

class OneCallWeatherNotifier extends ChangeNotifier {
  OpenWeatherMap? _weather;
  OpenWeatherMap? get weather => _weather;

  final LatLng _location;

  OneCallWeatherNotifier(this._location) {
    final apiOneCallUrl = Uri.https(Config.apiBaseUrl, 'data/2.5/onecall', {
      'lat': _location.latitude.toString(),
      'lon': _location.longitude.toString(),
      'appid': Config.appId,
      'units': 'metric',
      'lang': 'en',
    });
    _getWeather(apiOneCallUrl.toString());
  }

  _getWeather(String url) async {
    _weather = await OneCallApiService().fetchWeatherData(url);
    notifyListeners();
  }

  reloadWeather() {
    final apiOneCallUrl = Uri.https(Config.apiBaseUrl, 'data/2.5/onecall', {
      'lat': _location.latitude.toString(),
      'lon': _location.longitude.toString(),
      'appid': Config.appId,
      'units': 'metric',
      'lang': 'en',
    });
    _getWeather(apiOneCallUrl.toString());
  }
}
