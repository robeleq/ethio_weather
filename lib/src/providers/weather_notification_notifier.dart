import 'package:ethio_weather/src/styles/theme_scheme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  String CURRENT_THEME_ID = "current_theme_id";

  ThemeData _themeCurrent = ThemeScheme.lightTheme();
  ThemeData get theme => _themeCurrent;

  getCurrentTheme() => _themeCurrent;

  ThemeNotifier() {
    _getCurrentTheme();
  }

  void setTheme(ThemeData theme) {
    _themeCurrent = theme;
    _saveThemeToSharedPref(theme);
    notifyListeners();
  }

  _getCurrentTheme() async {
    int currentThemeId = await _getThemeFromSharedPref();
    _themeCurrent = (currentThemeId == 0) ? ThemeScheme.lightTheme() : ThemeScheme.darkTheme();
    notifyListeners();
  }

  Future<int> _getThemeFromSharedPref() async {
    final pref = await SharedPreferences.getInstance();
    final currentThemeId = pref.getInt(CURRENT_THEME_ID);
    if (currentThemeId == null) return 0;
    return currentThemeId;
  }

  void _saveThemeToSharedPref(ThemeData theme) async {
    final pref = await SharedPreferences.getInstance();
    int themeId = (theme.brightness == Brightness.light) ? ThemeScheme.THEME_LIGHT : ThemeScheme.THEME_DARK;
    await pref.setInt(CURRENT_THEME_ID, themeId);
  }
}
