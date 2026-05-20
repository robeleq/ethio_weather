
import 'package:easy_audience_network/easy_audience_network.dart';
import 'package:ethio_weather/src/services/onecall_api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:workmanager/workmanager.dart';

import 'src/app.dart';
import 'src/pages/hourly_page.dart';
import 'src/providers/providers.dart';
import 'src/services/location_service.dart';

// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

/*
Future<void> _fetchWeatherDataIsolate(SendPort sendPort) async {
  try {
    // Check if there is an internet connection
    final hasInternetConnection = await InternetConnectionChecker.instance.hasConnection;

    if (hasInternetConnection) {
      // Get the user's current location
      final userLocation = await LocationService().getUserLocation(true);

      // Get the current weather information for the location
      final weather = await OneCallApiService().fetchWeatherData(userLocation.latLong);

      if (weather.hourly == null || weather.hourly!.isEmpty) {
        sendPort.send(null);
      } else {
        sendPort.send(weather);
      }
    } else {
      sendPort.send(null);
    }
  } catch (e) {
    sendPort.send(null);
  }
}

void callbackDispatcherWithIsolate() {
  // Register the background isolate with the root isolate.
  BackgroundIsolateBinaryMessenger.ensureInitialized(RootIsolateToken.instance!);

  Workmanager().executeTask((task, inputData) async {
    final receivePort = ReceivePort();

    try {
      // Spawn the isolate
      await Isolate.spawn(_fetchWeatherDataIsolate, receivePort.sendPort);

      // Await the response from the isolate
      receivePort.listen((result) {
        if (result != null) {
          // Process the result (e.g., show a notification)
          final weather = result as OpenWeatherMap; // casting to your data type

          // Generate hourly forecast
          final hourlyItems = List<HourlyItem>.generate(weather.hourly!.length, (int index) {
            return HourlyItem(hourly: weather.hourly![index]);
          });

          HourlyItem currentHourly = hourlyItems[0];
          final currentHourlyWeather = currentHourly.hourly.weather?.first;

          // Initialize Flutter Local Notifications
          FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

          const AndroidNotificationChannel channel = AndroidNotificationChannel(
            "com.ethio.weather", // Channel Id
            "ethio_weather_channel", // Channel Name
            description: 'Channel description',
            importance: Importance.max,
            playSound: true,
          );

          // Set Android notification details
          AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            color: Colors.blue,
            playSound: true,
            icon: '@mipmap/ic_launcher',
          );

          // Set iOS notification details
          DarwinNotificationDetails iOSNotificationDetails = const DarwinNotificationDetails();

          NotificationDetails platformSpecificsNotificationDetails = NotificationDetails(
            android: androidNotificationDetails,
            iOS: iOSNotificationDetails,
          );

          // Show local notification with the result from the isolate
          flutterLocalNotificationsPlugin.show(
            id: 0,
            title: "Feels like ${currentHourly.hourly.feelsLike}°C",
            body: "${currentHourlyWeather?.description} is expected",
            notificationDetails: platformSpecificsNotificationDetails,
            payload: null,
          );
        }
      });

      // Notify that the task was completed successfully
      return Future.value(true);
    } catch (e) {
      debugPrint('Error during isolate task: $e');
      return Future.value(false);
    } finally {
      receivePort.close();
    }
  });
}
*/

void callbackDispatcherWeatherNotification() {
  Workmanager().executeTask((task, inputData) async {
    try {
      // Check if there is an internet connection
      final hasInternetConnection = await InternetConnectionChecker.instance.hasConnection;
      if (!hasInternetConnection) {
        // If no internet, stop the task
        return Future.value(false);
      }

      // Get the user's current location
      final userLocation = await LocationService().getUserLocation(hasInternetConnection);

      // Get the current weather information for the location
      final weather = await OneCallApiService().fetchWeatherData(userLocation.latLong);
      if (weather.hourly == null || weather.hourly!.isEmpty) {
        return Future.value(false);
      }

      // Generate hourly forecast
      final hourlyItems = List<HourlyItem>.generate(weather.hourly!.length, (int index) {
        return HourlyItem(hourly: weather.hourly![index]);
      });

      HourlyItem currentHourly = hourlyItems[0];
      final currentHourWeather = currentHourly.hourly.weather?[0];

      /*
      AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 1,
            color: Colors.red,
            channelKey: 'com.ethio.weather',
            title: "Feels like ${currentHourly.hourly.feelsLike}°C",
            body: "${currentHourWeather?.description} is expected",
            criticalAlert: true,
            wakeUpScreen: true,
            payload: {'data': 'example payload'},
          ));
      */

      // Initialize Flutter Local Notifications
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        "com.ethio.weather", // Channel Id
        "ethio_weather_channel", // Channel Name
        description: 'Channel description',
        importance: Importance.max,
        playSound: true,
      );

      // Set Android notification details
      AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        color: Colors.blue,
        playSound: true,
        icon: '@mipmap/ic_launcher',
      );

      // Set iOS notification details
      DarwinNotificationDetails iOSNotificationDetails = const DarwinNotificationDetails();

      NotificationDetails platformSpecificsNotificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: iOSNotificationDetails,
      );

      // Show the local notification
      await flutterLocalNotificationsPlugin.show(
        id: 0,
        title: "Feels like ${currentHourly.hourly.feelsLike}°C",
        body: "${currentHourWeather?.description} is expected",
        notificationDetails: platformSpecificsNotificationDetails,
        payload: null,
      );

      // Return true when the task is completed successfully
      return Future.value(true);
    } catch (e) {
      // Catch any error and return false
      debugPrint('Error during background task: $e');
      return Future.value(false);
    }
  });
}

Future<void> main() async {
  // Load the .env file contents into dotenv.
  await dotenv.load(fileName: '.env');

  WidgetsFlutterBinding.ensureInitialized();

  final hasInternetConnection = await InternetConnectionChecker.instance.hasConnection;

  // Facebook Audience Network Initialization
  EasyAudienceNetwork.init(
      testingId: "37b1da9d-b48c-4103-a393-2e095e734bd6", //optional
      testMode: true, //optional
      iOSAdvertiserTrackingEnabled: true //default false
  );

  // Local Notification Initialization
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');

  DarwinInitializationSettings initializationSettingsIOS = const DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: false,
  );

  InitializationSettings initializePlatformSpecificSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS
  );

  await flutterLocalNotificationsPlugin.initialize(
    settings: initializePlatformSpecificSettings,
    onDidReceiveNotificationResponse: (NotificationResponse? response) {
      if (kDebugMode) {
        print(response);
      }
    },
  );

  /*
  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  AwesomeNotifications().initialize(null,
      [
        NotificationChannel(
            ledColor: Colors.pink,
            enableVibration: true,
            channelKey: "com.ethio.weather",
            channelName: "ethio_weather_channel",
            channelDescription: 'Channel description')
      ]);
  */

  // WorkManager initialization
  Workmanager().initialize(
      callbackDispatcherWeatherNotification,
  );

  // LocalNotificationService().initNotifications();

  runApp(ProviderScope(
    overrides: [
      // override the previous value with the new object
      hasInternetConnectionProvider.overrideWithValue(hasInternetConnection),
    ],
    child: const EthioWeatherApp(),
  ));
}
