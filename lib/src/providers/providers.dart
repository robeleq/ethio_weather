import 'package:ethio_weather/src/providers/theme_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeChangeNotifierProvider = ChangeNotifierProvider((ref) {
  return ThemeNotifier();
});
