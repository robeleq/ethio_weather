import 'package:ethio_weather/src/router.dart';
import 'package:flutter/material.dart';

class EthioWeatherApp extends StatelessWidget {
  const EthioWeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ethio Weather App",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: onGenerateRoute,
      initialRoute: homePageRoute,
    );
  }
}
