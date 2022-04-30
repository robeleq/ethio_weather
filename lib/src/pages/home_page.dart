import 'package:ethio_weather/src/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../locales/app_localizations.dart';
import '../providers/providers.dart';
import '../styles/colors.dart';

class HomePage extends ConsumerStatefulWidget {
  final String title;

  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with TickerProviderStateMixin<HomePage> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final themeProvider = ref.watch(themeChangeNotifierProvider);
    final _theme = themeProvider.getCurrentTheme();

    final Color _titleColor = _theme.brightness == Brightness.light ? lPrimaryTextColor : dPrimaryTextColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: _theme.scaffoldBackgroundColor,
        title: Text(
          widget.title,
          style: TextStyle(color: _titleColor),
          textAlign: TextAlign.left,
        ),
      ),
      body: Navigator(
        key: _navigatorKey,
        onGenerateRoute: onGenerateRoute,
        initialRoute: todayPageRoute,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: _theme.backgroundColor,
        selectedItemColor: _theme.focusColor,
        unselectedItemColor: _theme.focusColor.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        onTap: _onTap,
        currentIndex: _currentIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.calendar_today),
            label: AppLocalizations.of(context)!.translate("tab_label_today"),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.lock_clock),
            label: AppLocalizations.of(context)!.translate("tab_label_hourly"),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.calendar_view_week),
            label: AppLocalizations.of(context)!.translate("tab_label_weekly"),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: AppLocalizations.of(context)!.translate("tab_label_settings"),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _onTap(int tabIndex) {
    switch (tabIndex) {
      case 0:
        _navigatorKey.currentState?.pushReplacementNamed(todayPageRoute);
        break;
      case 1:
        _navigatorKey.currentState?.pushReplacementNamed(hourlyPageRoute);
        break;
      case 2:
        _navigatorKey.currentState?.pushReplacementNamed(weeklyPageRoute);
        break;
      case 3:
        _navigatorKey.currentState?.pushReplacementNamed(settingsPageRoute);
        break;
      default:
        _navigatorKey.currentState?.pushReplacementNamed(todayPageRoute);
        break;
    }
    setState(() {
      _currentIndex = tabIndex;
    });
  }
}
