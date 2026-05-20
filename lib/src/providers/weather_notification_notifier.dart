import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherNotificationNotifier extends ChangeNotifier {
  String SHOW_WEATHER_NOTIFICATION = "show_weather_notification";

  bool _showWeatherNotification = false;
  bool get showWeatherNotification => _showWeatherNotification;

  getShowWeatherNotification() => _showWeatherNotification;

  WeatherNotificationNotifier() {
    _getShowWeatherNotification();
  }

  void setShowWeatherNotification(bool isShowWeatherNotification) {
    _showWeatherNotification = isShowWeatherNotification;
    _saveWeatherNotificationToSharedPref(isShowWeatherNotification);
    notifyListeners();
  }

  _getShowWeatherNotification() async {
    bool isShowWeatherNotification = await _getWeatherNotificationFromSharedPref();
    _showWeatherNotification = isShowWeatherNotification;
    notifyListeners();
  }

  Future<bool> _getWeatherNotificationFromSharedPref() async {
    final pref = await SharedPreferences.getInstance();
    final isShowWeatherNotification = pref.getBool(SHOW_WEATHER_NOTIFICATION);
    if (isShowWeatherNotification == null) return false;
    return isShowWeatherNotification;
  }

  void _saveWeatherNotificationToSharedPref(bool isShowWeatherNotification) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool(SHOW_WEATHER_NOTIFICATION, isShowWeatherNotification);
  }
}
