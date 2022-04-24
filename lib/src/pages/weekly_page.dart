import 'package:basic_utils/basic_utils.dart';
import 'package:ethio_weather/src/models/daily_forecast.dart';
import 'package:ethio_weather/src/models/open_weather_map.dart';
import 'package:ethio_weather/src/widgets/no_internet_connection_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';

import '../config.dart';
import '../providers/providers.dart';
import '../styles/colors.dart';

class WeeklyPage extends ConsumerStatefulWidget {
  final String title;

  const WeeklyPage({Key? key, required this.title}) : super(key: key);

  @override
  ConsumerState<WeeklyPage> createState() => _WeeklyPageState();
}

class _WeeklyPageState extends ConsumerState<WeeklyPage> with TickerProviderStateMixin<WeeklyPage> {
  List<DailyItem> _dailyForecastItems = <DailyItem>[];

  @override
  void initState() {
    super.initState();

    final _openWeatherMap = ref.read(openWeatherMapNotifierProvider);

    if (_openWeatherMap.daily != null) {
      _dailyForecastItems = generateDailyForecastItem(_openWeatherMap);
    }
  }

  ExpansionPanel _buildExpansionPanel(DailyItem dailyItem, ThemeData _theme) {
    return ExpansionPanel(
      canTapOnHeader: true,
      backgroundColor: _theme.brightness == Brightness.dark ? dSecondaryDarkColor : lSecondaryLightColor,
      headerBuilder: (context, isExpanded) {
        return Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      DateFormat('EEEE dd/MM/yyyy')
                          .format(DateTime.fromMillisecondsSinceEpoch(dailyItem.daily.dt! * 1000)),
                      style: const TextStyle(fontSize: 13.0),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "${dailyItem.daily.temp?.min}°C ${dailyItem.daily.temp?.max}°C",
                      style: const TextStyle(fontSize: 13.0),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Image.asset(
                      'assets/images/icons/${dailyItem.daily.weather?[0].icon}@2x.png',
                      height: 48,
                      width: 48,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "${dailyItem.daily.humidity}%",
                      style: const TextStyle(fontSize: 14.0),
                    ),
                  ),
                ),
              ],
            ));
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Text(
              "${DateFormat('EE dd').format(DateTime.fromMillisecondsSinceEpoch(dailyItem.daily.dt! * 1000))} | Day",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Row(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/icons/${dailyItem.daily.weather?[0].icon}@2x.png',
                      height: 48,
                      width: 48,
                      fit: BoxFit.fitWidth,
                    ),
                    Text("${dailyItem.daily.temp?.day}°C",
                        style: const TextStyle(
                          fontSize: 18,
                        )),
                    const SizedBox(
                      width: 16.0,
                    ),
                  ],
                )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          StringUtils.capitalize("${dailyItem.daily.weather?[0].description}", allWords: true),
                          style: const TextStyle(fontSize: 12.0),
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          "${dailyItem.daily.temp?.min}°C / ${dailyItem.daily.temp?.max}°C",
                          style: const TextStyle(fontSize: 12.0),
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          "Feels like ${dailyItem.daily.feelsLike?.day}°C",
                          style: const TextStyle(fontSize: 12.0),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: _theme.brightness == Brightness.dark ? dPrimaryBackgroundColor : lPrimaryBackgroundColor,
                width: 0.5,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            BoxedIcon(
                              WeatherIcons.humidity,
                              color: _theme.focusColor,
                              size: 20.0,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Padding(
                                  padding: EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    'Humidity',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    "${dailyItem.daily.humidity} %",
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            BoxedIcon(
                              WeatherIcons.sunrise,
                              color: _theme.focusColor,
                              size: 20.0,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Padding(
                                  padding: EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    'UV Index',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    "${dailyItem.daily.uvi}",
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            WindIcon(
                              degree: num.parse("${dailyItem.daily.windDeg}"),
                              color: _theme.iconTheme.color,
                              size: 24.0,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Padding(
                                  padding: EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    'Wind',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    "${dailyItem.daily.windSpeed} m/s",
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Text(
              "${DateFormat('EE dd').format(DateTime.fromMillisecondsSinceEpoch(dailyItem.daily.dt! * 1000))} | Night",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Row(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/icons/${dailyItem.daily.weather?[0].icon}@2x.png',
                      height: 48,
                      width: 48,
                      fit: BoxFit.fitWidth,
                    ),
                    Text("${dailyItem.daily.temp?.night}°C",
                        style: const TextStyle(
                          fontSize: 18,
                        )),
                    const SizedBox(
                      width: 16.0,
                    ),
                  ],
                )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          StringUtils.capitalize("${dailyItem.daily.weather?[0].description}", allWords: true),
                          style: const TextStyle(fontSize: 12.0),
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          "${dailyItem.daily.temp?.min}°C / ${dailyItem.daily.temp?.max}°C",
                          style: const TextStyle(fontSize: 12.0),
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          "Feels like ${dailyItem.daily.feelsLike?.night}°C",
                          style: const TextStyle(fontSize: 12.0),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: _theme.brightness == Brightness.dark ? dPrimaryBackgroundColor : lPrimaryBackgroundColor,
                width: 0.5,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            BoxedIcon(
                              WeatherIcons.humidity,
                              color: _theme.focusColor,
                              size: 20.0,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Padding(
                                  padding: EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    'Humidity',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    "${dailyItem.daily.humidity} %",
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            BoxedIcon(
                              WeatherIcons.sunrise,
                              color: _theme.focusColor,
                              size: 20.0,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Padding(
                                  padding: EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    'UV Index',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    "${dailyItem.daily.uvi}",
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            WindIcon(
                              degree: num.parse("${dailyItem.daily.windDeg}"),
                              color: _theme.iconTheme.color,
                              size: 24.0,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Padding(
                                  padding: EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    'Wind',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    "${dailyItem.daily.windSpeed} m/s",
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      isExpanded: dailyItem.isExpanded,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = ref.watch(themeChangeNotifierProvider);
    final _theme = themeProvider.getCurrentTheme();

    final _internetConnected = ref.watch(connectionStateProvider);

    final _userLocation = ref.watch(userLocationProvider);

    final Color _titleColor = _theme.brightness == Brightness.light ? lPrimaryTextColor : dPrimaryTextColor;

    // Reloads the weather data when connection is available
    if (_internetConnected) {
      if (_dailyForecastItems.isEmpty) {
        final apiOneCallUrl = Uri.https(Config.apiBaseUrl, 'data/2.5/onecall', {
          'lat': _userLocation.latitude.toString(),
          'lon': _userLocation.longitude.toString(),
          'appid': Config.appId,
          'units': 'metric',
          'lang': 'en',
        });
        ref.read(openWeatherMapNotifierProvider.notifier).getWeather(apiOneCallUrl.toString());

        final _openWeatherMap = ref.watch(openWeatherMapNotifierProvider);

        if (_openWeatherMap.hourly != null) {
          _dailyForecastItems = generateDailyForecastItem(_openWeatherMap);
        }
      }
    }

    return _internetConnected
        ? Center(
            child: SingleChildScrollView(
              child: (_dailyForecastItems.isNotEmpty)
                  ? ExpansionPanelList(
                      elevation: 3,
                      animationDuration: const Duration(milliseconds: 600),
                      expansionCallback: (index, isExpanded) {
                        setState(() {
                          _dailyForecastItems[index].isExpanded = !isExpanded;
                        });
                      },
                      children:
                          _dailyForecastItems.map((hourlyItem) => _buildExpansionPanel(hourlyItem, _theme)).toList(),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          )
        : const NoInternetConnection();
  }

  List<DailyItem> generateDailyForecastItem(OpenWeatherMap _openWeatherMap) {
    return List<DailyItem>.generate(
      _openWeatherMap.daily!.length,
      (int index) {
        return DailyItem(
          daily: _openWeatherMap.daily![index],
        );
      },
    );
  }
}

// stores ExpansionPanel state information
class DailyItem {
  DailyItem({
    required this.daily,
    this.isExpanded = false,
  });

  DailyForecast daily;
  bool isExpanded;
}
