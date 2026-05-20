import 'package:ethio_weather/src/providers/language_notifier.dart';
import 'package:ethio_weather/src/providers/weather_notification_notifier.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:workmanager/workmanager.dart';

import '../services/local_notification_service.dart';
import './connection_notifier.dart';
import './onecall_weather_notifier.dart';
import './theme_notifier.dart';
import 'location_notifier.dart';

final themeChangeNotifierProvider = ChangeNotifierProvider((ref) {
  return ThemeNotifier();
});

final weatherNotificationChangeNotifierProvider = ChangeNotifierProvider((ref) {
  return WeatherNotificationNotifier();
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

final languageNotifierProvider = ChangeNotifierProvider((ref) {
  return LanguageNotifier();
});

final localNotificationServiceProvider = Provider<LocalNotificationService>((ref) {
  return LocalNotificationService();
});

