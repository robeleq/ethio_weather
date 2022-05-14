import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LangUtil {
  static Future<Locale> getCurrentLanguage() async {
    String languageCode = await _getLanguageCodeFromSharedPref();
    final Locale locale;
    switch (languageCode) {
      case "en":
        locale = const Locale("en");
        break;
      case "am":
        locale = const Locale('am');
        break;
      case "tg":
        locale = const Locale('tg');
        break;
      case "or":
        locale = const Locale('or');
        break;
      default:
        locale = const Locale("en");
    }
    return locale;
  }

  static Future<String> _getLanguageCodeFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    final currentLangCode = prefs.getString("currentLanguageCode");
    if (currentLangCode == null) {
      return "en";
    }
    return currentLangCode;
  }

  static void saveLanguageCodeToSharedPref(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("currentLanguageCode", locale.languageCode);

    if (kDebugMode) {
      print('Save locale is -> ${locale.languageCode}');
    }
  }
}
