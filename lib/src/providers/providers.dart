import 'package:flutter_riverpod/flutter_riverpod.dart';

import './connection_notifier.dart';
import './onecall_weather_notifier.dart';
import './theme_notifier.dart';
import 'location_notifier.dart';

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

final oneCallApiWeatherNotifierProvider = ChangeNotifierProvider((ref) {
  final userLocation = ref.read(userLocationNotifierProvider);
  return OneCallWeatherNotifier(userLocation.userLocation.latLong);
});

final userLocationNotifierProvider = ChangeNotifierProvider((ref) {
  final hasInternetConnection = ref.watch(connectionStateProvider);
  return LocationNotifier(hasInternetConnection);
});
