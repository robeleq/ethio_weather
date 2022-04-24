import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/providers.dart';
import '../styles/colors.dart';

class NoInternetConnection extends ConsumerWidget {
  const NoInternetConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProvider = ref.watch(themeChangeNotifierProvider);
    final _theme = themeProvider.getCurrentTheme();

    return Center(
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: _theme.brightness == Brightness.light ? lSecondaryLightColor : dSecondaryDarkColor,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 30,
              color: _theme.scaffoldBackgroundColor,
            ),
          ],
        ),
        child: const ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Icon(Icons.cloud_off, size: 48.0),
          title: Text(
            "No Internet Connection",
          ),
          subtitle: Text(
            "There is no internet connection. Please check your connection and try again.",
          ),
        ),
      ),
    );
  }
}
