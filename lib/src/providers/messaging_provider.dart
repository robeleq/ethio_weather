import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/firebase_messaging_service.dart';
import 'firebase_provider.dart';

final messagingServiceProvider = Provider<FirebaseMessagingService>((ref) {
	final messaging = ref.read(firebaseMessagingProvider);
	return FirebaseMessagingService(messaging);
});

final firebaseMessagingInitializerProvider = Provider((ref) {
	return ref.read(messagingServiceProvider).initMessaging();
});

final firebaseMessageHandlerProvider = Provider.family((ref, BuildContext context) {
	return ref.read(messagingServiceProvider).handleMessage(context);
});
