import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

import '../models/open_weather_map.dart';
import '../pages/hourly_page.dart';
import '../providers/providers.dart';

import 'location_service.dart';
import 'onecall_api_service.dart';

class LocalNotificationService {

  LocalNotificationService();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    "com.ethio.weather", // Channel Id
    "ethio_weather_channel", // Channel Name
    description: 'channel description',
    importance: Importance.max,
    playSound: true,
  );

  static AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
    channel.id,
    channel.name,
    channelDescription: channel.description,
    color: Colors.blue,
    playSound: true,
    icon: '@mipmap/ic_launcher',
  );

  static DarwinNotificationDetails iOSNotificationDetails = const DarwinNotificationDetails();

  static NotificationDetails platformSpecificsNotificationDetails =
      NotificationDetails(android: androidNotificationDetails, iOS: iOSNotificationDetails);

  Future<void> initNotifications() async {
    await _configureLocalTimeZone();

    if (Platform.isIOS) {
      _requestIOSPermissions();
    }

    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    DarwinInitializationSettings initializationSettingsIOS = const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: false,
    );

    InitializationSettings initializePlatformSpecificSettings =
        InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(
      settings: initializePlatformSpecificSettings,
      onDidReceiveNotificationResponse: (NotificationResponse? response) {
        if (kDebugMode) {
          print(response);
        }
      },
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<void> _requestIOSPermissions() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  Future<void> showNotificationForeground(BuildContext context,
      {int id = 0, String? title, String? body, String? payload}) async {
    flutterLocalNotificationsPlugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: platformSpecificsNotificationDetails,
      payload: payload!,
    );
  }

  Future showNotification({int id = 0, String? title, String? body, String? payload}) async {
    await flutterLocalNotificationsPlugin.show(
      id: 0,
      title: title,
      body: body,
      notificationDetails: platformSpecificsNotificationDetails,
      payload: 'item x',
    );
  }

  Future<void> scheduledNotification(int id, String title, String body, DateTime scheduledTime) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: tz.TZDateTime.from(scheduledTime, tz.local),
      notificationDetails: platformSpecificsNotificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }

  Future<void> scheduleHourlyNotification(DateTime selectedTime) async {
    if (selectedTime.isBefore(DateTime.now())) {
      // Ensure that the selected time is in the future
      selectedTime = DateTime.now().add(const Duration(minutes: 15));
    }

    // Convert the time to timezone-aware TZDateTime
    final tz.TZDateTime scheduledTime = tz.TZDateTime.from(selectedTime, tz.local);

    // Check for internet connection
    final hasInternetConnection = await InternetConnectionChecker.instance.hasConnection;
    if (!hasInternetConnection) {
      // Optionally retry later or return if no internet
      debugPrint('No internet connection. Unable to fetch weather data.');
      return;
    }

    // Get user location
    final userLocation = await LocationService().getUserLocation(hasInternetConnection);

    // Fetch weather data
    final weather = await OneCallApiService().fetchWeatherData(userLocation.latLong);
    if (weather.hourly == null || weather.hourly!.isEmpty) {
      debugPrint('No hourly weather data available.');
      return;
    }

    // Extract the first hourly forecast
    final currentHourly = HourlyItem(hourly: weather.hourly!.first);
    final currentHourWeather = currentHourly.hourly.weather?.first;

    // If no valid weather data, stop the process
    if (currentHourWeather == null) {
      debugPrint('Weather data is not available.');
      return;
    }

    // Schedule the local notification
    try {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        id: 0,
        title: "Feels like ${currentHourly.hourly.feelsLike}°C",
        body: "${currentHourWeather.description} is expected",
        scheduledDate: scheduledTime,
        notificationDetails: platformSpecificsNotificationDetails,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time, // Repeat every hour at the same minute
      );

      debugPrint('Notification scheduled successfully for $scheduledTime');
    } catch (e) {
      debugPrint('Error scheduling notification: $e');
    }
  }

  Future<void> cancelAllNotifications() async {
    flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();

    final currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone.identifier));
  }
}