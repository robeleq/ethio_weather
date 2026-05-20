
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAppInitializerProvider = FutureProvider<FirebaseApp>((ref) async {
	return await Firebase.initializeApp(
		options: const FirebaseOptions(
			appId: '1:124120335718:android:e7b3f604deb5571cd374a7',
			apiKey: 'AIzaSyCX7jCG2S9JG_IR_fLJwbPUldVpGhl_aGE',
			messagingSenderId: '124120335718',
			projectId: 'ethio-weather-app',
		)
	);
});

final firebaseMessagingProvider = Provider<FirebaseMessaging>((ref) {
	return FirebaseMessaging.instance;
});

final firebaseMessagingTopicSubscriberProvider = Provider.family((ref, String topic) {
	ref.read(firebaseMessagingProvider).subscribeToTopic(topic);
});
