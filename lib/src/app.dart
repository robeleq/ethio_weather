import 'package:flutter/material.dart';

import '../src/pages/home_page.dart';

class EthioWeatherApp extends StatelessWidget {
  const EthioWeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ethio Weather App",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Ethio Weather'),
    );
  }
}
