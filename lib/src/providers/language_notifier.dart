import 'package:ethio_weather/src/locales/supported_locale.dart';
import 'package:flutter/material.dart';

import '../locales/app_locale.dart';
import '../utils/lang_util.dart';

class LanguageNotifier extends ChangeNotifier {
  String _currentLanguageCode = "en";
  SupportedLocale? _supportedLocale;

  LanguageNotifier() {
    _getCurrentLocale();
  }

  String get currentLanguageCode => _currentLanguageCode;
  SupportedLocale? get currentLocale => _supportedLocale;

  _getCurrentLocale() async {
    Locale _locale = await LangUtil.getCurrentLanguage();

    _setCurrentLocale(_locale.languageCode);

    notifyListeners();
  }

  updateCurrentLocale(String langCode) {
    _setCurrentLocale(langCode);

    notifyListeners();
  }

  _setCurrentLocale(String langCode) {
    _currentLanguageCode = langCode;
    String lang = appLocale.supportedLanguageMap[langCode] ?? "English";

    _supportedLocale = SupportedLocale(langCode, lang);
  }
}
