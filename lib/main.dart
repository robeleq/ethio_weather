import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'src/app.dart';
import 'src/providers/providers.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');

  WidgetsFlutterBinding.ensureInitialized();
  final hasInternetConnection = await InternetConnectionChecker().hasConnection;

  runApp(ProviderScope(
    overrides: [
      // override the previous value with the new object
      hasInternetConnectionProvider.overrideWithValue(hasInternetConnection),
    ],
    child: const EthioWeatherApp(),
  ));
}
