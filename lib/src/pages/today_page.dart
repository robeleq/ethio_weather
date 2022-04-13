import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_icons/weather_icons.dart';

import '../providers/providers.dart';
import '../styles/colors.dart';
import '../widgets/current_weather_card.dart';

class TodayPage extends ConsumerStatefulWidget {
  final String title;

  const TodayPage({Key? key, required this.title}) : super(key: key);

  @override
  ConsumerState<TodayPage> createState() => _TodayPageState();
}

class _TodayPageState extends ConsumerState<TodayPage> with TickerProviderStateMixin<TodayPage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = ref.watch(themeChangeNotifierProvider);
    final _theme = themeProvider.getCurrentTheme();

    final Color _titleColor = _theme.brightness == Brightness.light ? lPrimaryTextColor : dPrimaryTextColor;

    final _openWeatherMapData = ref.watch(openWeatherMapDataProvider);

    const dynamic tempMin = 10;
    const dynamic tempMax = 21;

    double screenWidth = MediaQuery.of(context).size.width;
    double? screenHeight = MediaQuery.of(context).size.height * 0.25;

    return Stack(children: <Widget>[
      Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/images/photo_addis_ababa.jpg"),
          ),
        ),
      ),
      _openWeatherMapData.when(
        data: (_data) => SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: screenHeight - 48.0, bottom: 16.0),
            child: Column(
              children: [
                CurrentWeatherCard(_data.current!),
                Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                  margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                  child: Card(
                    elevation: 8.0,
                    margin: const EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Text(
                                  "11:00",
                                  style: TextStyle(fontSize: 12.0),
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                BoxedIcon(
                                  WeatherIcons.day_cloudy,
                                  color: _theme.iconTheme.color,
                                  size: 24.0,
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                const Text(
                                  "22°C",
                                  style: TextStyle(fontSize: 12.0),
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const <Widget>[
                                    BoxedIcon(
                                      WeatherIcons.humidity,
                                      color: Colors.blueAccent,
                                      size: 10.0,
                                    ),
                                    Text(
                                      "22%",
                                      style: TextStyle(fontSize: 12.0),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Text(
                                  "12:00",
                                  style: TextStyle(fontSize: 12.0),
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                BoxedIcon(
                                  WeatherIcons.day_cloudy,
                                  color: _theme.iconTheme.color,
                                  size: 24.0,
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                const Text(
                                  "22°C",
                                  style: TextStyle(fontSize: 12.0),
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const <Widget>[
                                    BoxedIcon(
                                      WeatherIcons.humidity,
                                      color: Colors.blueAccent,
                                      size: 10.0,
                                    ),
                                    Text(
                                      "22%",
                                      style: TextStyle(fontSize: 12.0),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Text(
                                  "13:00",
                                  style: TextStyle(fontSize: 12.0),
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                BoxedIcon(
                                  WeatherIcons.day_cloudy,
                                  color: _theme.iconTheme.color,
                                  size: 24.0,
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                const Text(
                                  "22°C",
                                  style: TextStyle(fontSize: 12.0),
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const <Widget>[
                                    BoxedIcon(
                                      WeatherIcons.humidity,
                                      color: Colors.blueAccent,
                                      size: 10.0,
                                    ),
                                    Text(
                                      "22%",
                                      style: TextStyle(fontSize: 12.0),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Text(
                                  "14:00",
                                  style: TextStyle(fontSize: 12.0),
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                BoxedIcon(
                                  WeatherIcons.day_cloudy,
                                  color: _theme.iconTheme.color,
                                  size: 24.0,
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                const Text(
                                  "22°C",
                                  style: TextStyle(fontSize: 12.0),
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const <Widget>[
                                    BoxedIcon(
                                      WeatherIcons.humidity,
                                      color: Colors.blueAccent,
                                      size: 10.0,
                                    ),
                                    Text(
                                      "22%",
                                      style: TextStyle(fontSize: 12.0),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Text(
                                  "15:00",
                                  style: TextStyle(fontSize: 12.0),
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                BoxedIcon(
                                  WeatherIcons.day_cloudy,
                                  color: _theme.iconTheme.color,
                                  size: 24.0,
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                const Text(
                                  "22°C",
                                  style: TextStyle(fontSize: 12.0),
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const <Widget>[
                                    BoxedIcon(
                                      WeatherIcons.humidity,
                                      color: Colors.blueAccent,
                                      size: 10.0,
                                    ),
                                    Text(
                                      "22%",
                                      style: TextStyle(fontSize: 12.0),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        error: (err, s) => Text(err.toString()),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    ]);
  }
}
