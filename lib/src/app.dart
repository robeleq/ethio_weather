import 'package:ethio_weather/src/pages/hourly_page.dart';
import 'package:ethio_weather/src/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workmanager/workmanager.dart';

import 'locales/app_locale.dart';
import 'locales/app_localizations_delegate.dart';
import 'models/open_weather_map.dart';
import 'pages/home_page.dart';
import 'providers/firebase_provider.dart';
import 'providers/providers.dart';
import 'utils/lang_util.dart';

class EthioWeatherApp extends ConsumerStatefulWidget {
  const EthioWeatherApp({Key? key}) : super(key: key);

  @override
  ConsumerState<EthioWeatherApp> createState() => _EthioWeatherAppState();
}

class _EthioWeatherAppState extends ConsumerState<EthioWeatherApp> {
  late AppLocalizationsDelegate _newLocaleDelegate;

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppLocalizationsDelegate(newLocale: locale);
    });
  }

  @override
  void initState() {
    super.initState();

    // LocalNotification initialization
    final localNotificationService = ref.read(localNotificationServiceProvider);
    localNotificationService.initNotifications();

    _newLocaleDelegate = const AppLocalizationsDelegate(newLocale: null);
    appLocale.onLocaleChanged = onLocaleChange;

    LangUtil.getCurrentLanguage().then((locale) {
      onLocaleChange(locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Watch to see if the firebase has been initialized
    final initialize = ref.watch(firebaseAppInitializerProvider);

    final themeProvider = ref.watch(themeChangeNotifierProvider);
    final theme = themeProvider.getCurrentTheme();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Ethio Weather",
      theme: theme,
      localizationsDelegates: [
        _newLocaleDelegate,
        // A class which loads the translations from JSON files
        const AppLocalizationsDelegate(),
        // Built-in localization of basic text for Material widgets
        GlobalMaterialLocalizations.delegate,
        // Built-in localization for text direction LTR/RTL
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: appLocale.supportedLocales(),
      onGenerateRoute: onGenerateRoute,
      // initialRoute: homePageRoute,
      home: initialize.when(
        data: (firebaseApp) {
          return const HomePage(title: "Ethio Weather");
        },
        loading: () => const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        error: (e, stack) => Scaffold(
          body: Center(
            child: Text('Error initializing Firebase: $e'),
          ),
        ),
      ),
    );
  }
}
