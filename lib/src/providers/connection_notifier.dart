import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectionNotifier extends StateNotifier<bool> {
  final bool hasInternetConnection;

  ConnectionNotifier(this.hasInternetConnection) : super(hasInternetConnection) {
    InternetConnectionChecker().onStatusChange.listen((connectionStatus) {
      state = connectionStatus == InternetConnectionStatus.connected;
    });
  }
}
