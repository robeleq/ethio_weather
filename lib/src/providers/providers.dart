import 'package:ethio_weather/src/config.dart';
import 'package:ethio_weather/src/models/open_weather_map.dart';
import 'package:ethio_weather/src/providers/theme_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/open_weather_map_service.dart';

final themeChangeNotifierProvider = ChangeNotifierProvider((ref) {
  return ThemeNotifier();
});

// Provider definition - reference to the whole OpenWeatherMapService()
final openWeatherMapServiceProvider = Provider((ref) {
  return OpenWeatherMapService();
});

// The FutureProvider will access the API and return OpenWeatherMap weather data
final openWeatherMapDataProvider = FutureProvider<OpenWeatherMap>((ref) async {
  return ref.read(openWeatherMapServiceProvider).geOneCallWeather(Config.ONECALL_API_ENDPOINT_URL.toString());
});
