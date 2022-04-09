import 'package:ethio_weather/src/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/providers.dart';

class EthioWeatherApp extends ConsumerStatefulWidget {
  const EthioWeatherApp({Key? key}) : super(key: key);

  @override
  ConsumerState<EthioWeatherApp> createState() => _EthioWeatherAppState();
}

class _EthioWeatherAppState extends ConsumerState<EthioWeatherApp> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = ref.watch(themeChangeNotifierProvider);
    final _theme = themeProvider.getCurrentTheme();

    return MaterialApp(
      title: "Ethio Weather App",
      theme: _theme,
      onGenerateRoute: onGenerateRoute,
      initialRoute: homePageRoute,
    );
  }
}
