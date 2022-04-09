import 'package:ethio_weather/src/pages/hourly_page.dart';
import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'pages/settings_page.dart';
import 'pages/today_page.dart';
import 'pages/weekly_page.dart';

const String homePageRoute = "Home";
const String todayPageRoute = "Today";
const String hourlyPageRoute = "Hourly";
const String weeklyPageRoute = "Weekly";
const String settingsPageRoute = "Settings";

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case todayPageRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => const TodayPage(
                title: "Today's Weather Forecast",
              ));
    case hourlyPageRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => const HourlyPage(
                title: "Hourly Weather Forecast",
              ));
    case weeklyPageRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => const WeeklyPage(
                title: "Weekly Weather Forecast",
              ));
    case settingsPageRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => const SettingsPage(
                title: "Settings Page",
              ));
    default:
      return MaterialPageRoute(
          builder: (BuildContext context) => const HomePage(
                title: "Ethio Weather App",
              ));
  }
}
