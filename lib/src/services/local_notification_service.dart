import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    "com.ethio.forex", // Channel Id
    "ethio_forex_channel", // Channel Name
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

  static Future<void> initNotifications() async {
    if (Platform.isIOS) {
      _requestIOSPermissions();
    }

    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        // This property is only applicable to iOS versions older than 10.
      },
    );

    InitializationSettings initializePlatformSpecificSettings =
        InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializePlatformSpecificSettings,
        onDidReceiveNotificationResponse: (NotificationResponse? response) {
      if (kDebugMode) {
        print(response);
      }
    });

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static Future<void> _requestIOSPermissions() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  static Future<void> showNotificationForeground(BuildContext context,
      {int id = 0, String? title, String? body, String? payload}) async {
    flutterLocalNotificationsPlugin.show(id, title, body, platformSpecificsNotificationDetails, payload: payload!);
  }

  static Future showNotification({int id = 0, String? title, String? body, String? payload}) async {
    await flutterLocalNotificationsPlugin.show(0, title, body, platformSpecificsNotificationDetails, payload: 'item x');
  }
}