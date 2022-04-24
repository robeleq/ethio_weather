import 'package:ethio_weather/src/models/open_weather_map.dart';
import 'package:ethio_weather/src/providers/connection_notifier.dart';
import 'package:ethio_weather/src/providers/theme_notifier.dart';
import 'package:ethio_weather/src/providers/weather_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/lat_lng.dart';
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

final userLocationProvider = Provider<LatLng>((ref) {
  throw UnimplementedError();
});

final openWeatherMapRepositoryProvider = Provider<WeatherRepository>((ref) {
  return OpenWeatherMapRepository();
});

final openWeatherMapNotifierProvider = StateNotifierProvider<OpenWeatherMapNotifier, OpenWeatherMap>((ref) {
  final userLocation = ref.watch(userLocationProvider);
  final openWeatherMapRepository = ref.watch(openWeatherMapRepositoryProvider);
  return OpenWeatherMapNotifier(openWeatherMapRepository, userLocation);
});
