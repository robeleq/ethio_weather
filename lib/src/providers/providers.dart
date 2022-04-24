import 'package:ethio_weather/src/models/open_weather_map.dart';
import 'package:ethio_weather/src/providers/connection_notifier.dart';
import 'package:ethio_weather/src/providers/theme_notifier.dart';
import 'package:ethio_weather/src/providers/weather_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/weather_repository.dart';

final themeChangeNotifierProvider = ChangeNotifierProvider((ref) {
  return ThemeNotifier();
});

final hasInternetConnectionProvider = Provider<bool>((ref) {
  throw UnimplementedError();
});

// Provider definition - connection listener
final connectionStateProvider = StateNotifierProvider<ConnectionNotifier, bool>((ref) {
  final hasInternetConnection = ref.watch(hasInternetConnectionProvider);
  return ConnectionNotifier(hasInternetConnection);
});

final openWeatherMapRepositoryProvider = Provider<WeatherRepository>(
  (ref) => OpenWeatherMapRepository(),
);

final openWeatherMapNotifierProvider = StateNotifierProvider<OpenWeatherMapNotifier, OpenWeatherMap>((ref) {
  return OpenWeatherMapNotifier(ref.watch(openWeatherMapRepositoryProvider));
});
