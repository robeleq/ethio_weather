import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config.dart';
import '../models/open_weather_map.dart';
import '../services/weather_repository.dart';

class OpenWeatherMapNotifier extends StateNotifier<OpenWeatherMap> {
  final WeatherRepository _weatherRepository;

  OpenWeatherMapNotifier(this._weatherRepository) : super(OpenWeatherMap()) {
    getWeather(Config.apiOneCallUrl.toString());
  }

  getWeather(String url) async {
    final weather = await _weatherRepository.fetchWeatherData(url);
    state = weather;
  }
}
