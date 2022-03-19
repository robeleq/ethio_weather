import 'package:ethio_weather/src/router.dart';
import 'package:ethio_weather/src/styles/colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin<HomePage> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Navigator(
        key: _navigatorKey,
        onGenerateRoute: onGenerateRoute,
        initialRoute: todayPageRoute,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: primaryColor,
        selectedItemColor: primaryTextColor,
        unselectedItemColor: primaryTextColor.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        onTap: _onTap,
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "Today",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.lock_clock), label: "Hourly"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_view_week), label: "Weekly"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
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
