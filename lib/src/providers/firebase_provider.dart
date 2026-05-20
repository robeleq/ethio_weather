
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*
final firebaseAppInitializerProvider = FutureProvider<FirebaseApp>((ref) async {
	return await Firebase.initializeApp(
		name: 'db2',
		options: Platform.isIOS || Platform.isMacOS
				? const FirebaseOptions(
			appId: '1:297855924061:ios:c6de2b69b03a5be8',
			apiKey: 'AIzaSyD_shO5mfO9lhy2TVWhfo1VUmARKlG4suk',
			projectId: 'flutter-firebase-plugins',
			messagingSenderId: '297855924061',
			databaseURL: 'https://flutterfire-cd2f7.firebaseio.com',
		)
				: const FirebaseOptions(
			appId: '1:810309180895:android:71da2048a513957bab386a',
			apiKey: 'AIzaSyCBXu-ua21pAX4RGJou3GqgWpNh55w0n3k',
			messagingSenderId: '810309180895',
			projectId: 'ethio-forex-app',
		),
	);
});
*/

final firebaseAppInitializerProvider = FutureProvider<FirebaseApp>((ref) async {
	return await Firebase.initializeApp(
		options: const FirebaseOptions(
			appId: '1:810309180895:android:71da2048a513957bab386a',
			apiKey: 'AIzaSyCBXu-ua21pAX4RGJou3GqgWpNh55w0n3k',
			messagingSenderId: '810309180895',
			projectId: 'ethio-forex-app',
		)
	);
});

final firebaseMessagingProvider = Provider<FirebaseMessaging>((ref) {
	return FirebaseMessaging.instance;
});

final firebaseMessagingTopicSubscriberProvider = Provider.family((ref, String topic) {
	ref.read(firebaseMessagingProvider).subscribeToTopic(topic);
});
