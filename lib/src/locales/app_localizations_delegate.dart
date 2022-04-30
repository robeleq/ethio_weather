import 'package:flutter/material.dart';

import '../locales/app_locale.dart';
import 'app_localizations.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  final Locale? newLocale;

  const AppLocalizationsDelegate({this.newLocale});

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    // return ['en', 'am'].contains(locale.languageCode);
    return appLocale.supportedLanguagesCodes.contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    AppLocalizations localizations = AppLocalizations(newLocale ?? locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => true;
}
