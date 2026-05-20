import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../styles/theme_scheme.dart';

class ThemeNotifier extends ChangeNotifier {
  static const String currentThemeIdKey = "current_theme_id";

  ThemeData _themeCurrent = ThemeScheme.lightTheme();
  ThemeData get theme => _themeCurrent;

  ThemeData getCurrentTheme() => _themeCurrent;

  ThemeNotifier() {
    _getCurrentTheme();
  }

  void setTheme(ThemeData theme) {
    _themeCurrent = theme;
    _saveThemeToSharedPref(theme);
    notifyListeners();
  }

  Future<void> _getCurrentTheme() async {
    int currentThemeId = await _getThemeFromSharedPref();
    _themeCurrent = (currentThemeId == ThemeScheme.themeLight) ? ThemeScheme.lightTheme() : ThemeScheme.darkTheme();
    notifyListeners();
  }

  Future<int> _getThemeFromSharedPref() async {
    final pref = await SharedPreferences.getInstance();
    final currentThemeId = pref.getInt(currentThemeIdKey);
    if (currentThemeId == null) return ThemeScheme.themeLight;
    return currentThemeId;
  }

  void _saveThemeToSharedPref(ThemeData theme) async {
    final pref = await SharedPreferences.getInstance();
    int themeId = (theme.brightness == Brightness.light) ? ThemeScheme.themeLight : ThemeScheme.themeDark;
    await pref.setInt(currentThemeIdKey, themeId);
  }
}
