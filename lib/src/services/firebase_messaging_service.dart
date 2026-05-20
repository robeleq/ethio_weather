import 'dart:convert';
import 'dart:io';

import 'package:ethio_weather/src/providers/providers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/notification_message.dart';
import '../widgets/notification_dialog.dart';

class FirebaseMessagingService {
  final Ref ref;
  final FirebaseMessaging _fcm;

  FirebaseMessagingService(this.ref, this._fcm);

  Future<void> initMessaging() async {

    // Automatically initialize FCM
    await _fcm.setAutoInitEnabled(true);

    // Request permissions
    await _fcm.requestPermission();

    // final token = getDeviceToken();
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    if (Platform.isIOS) {
      NotificationSettings settings = await _fcm.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (kDebugMode) {
        print('User granted permission: ${settings.authorizationStatus}');
      }
    }

    await _fcm.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> handleMessage(BuildContext context) async {
    // Terminated state
    // TODO: fix
    _fcm.getInitialMessage().then((message) async {
      if (message != null) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;

        // Handle user click on the notification
        if (android != null) {
          final pushMessage = NotificationMessage(
            id: message.messageId!,
            title: message.notification!.title!,
            body: message.notification!.body!,
            payload: jsonEncode(message.data),
          );

          if (!context.mounted) return;

          if (message.data.isNotEmpty) {
            showDialog(
              context: context,
              builder: (context) =>
                  NotificationDialog(
                    title: pushMessage.title,
                    body: pushMessage.body,
                  ),
            );
          }
        }
      }
    });

    // Foreground state
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;

      if(notification == null) return;

      AndroidNotification? android = message.notification?.android;

      if (android != null) {
        final localNotificationService = ref.read(localNotificationServiceProvider);

        localNotificationService.showNotificationForeground(
          context,
          id: notification.hashCode,
          title: notification.title,
          body: notification.body,
          payload: jsonEncode(message.toMap()),
        );

        final pushMessage = NotificationMessage(
          id: message.messageId!,
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: jsonEncode(message.data),
        );

        if(!context.mounted) return;

        if(message.data.isNotEmpty) {
          showDialog(
            context: context,
            builder: (context) => NotificationDialog(
              title: pushMessage.title,
              body: pushMessage.body,
            ),
          );
        }
      }
    });

    // Background state
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      // Handle user click on the notification
      if (android != null) {

        final pushMessage = NotificationMessage(
            id: message.messageId!,
            title: message.notification!.title!,
            body: message.notification!.body!,
            payload: jsonEncode(message.data),
        );

        if(!context.mounted) return;

        if(message.data.isNotEmpty) {
          showDialog(
            context: context,
            builder: (context) =>
                NotificationDialog(
                  title: pushMessage.title,
                  body: pushMessage.body,
                ),
          );
        }

        /*showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(notification?.title ?? ""),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(notification?.body ?? ""),
                    Text(message?.data['message'] ?? ""),
                  ],
                ),
              ),
            );
          },
        );*/
      }
    });
  }

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    // await Firebase.initializeApp();
    if (kDebugMode) {
      print("A message just showed up: ${message.messageId}");
    }
  }

  Future<String> getDeviceToken() async {
    final token = await _fcm.getToken();
    debugPrint('token: $token');
    return token.toString();
  }
}
