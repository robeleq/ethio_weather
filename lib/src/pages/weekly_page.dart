import 'package:basic_utils/basic_utils.dart';
import 'package:ethio_weather/src/models/daily_forecast.dart';
import 'package:ethio_weather/src/models/open_weather_map.dart';
import 'package:ethio_weather/src/widgets/no_internet_connection_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';

import '../locales/app_localizations.dart';
import '../providers/providers.dart';
import '../services/weather_description_locales.dart';
import '../styles/colors.dart';

class WeeklyPage extends ConsumerStatefulWidget {
  final String title;

  const WeeklyPage({Key? key, required this.title}) : super(key: key);

  @override
  ConsumerState<WeeklyPage> createState() => _WeeklyPageState();
}

class _WeeklyPageState extends ConsumerState<WeeklyPage> with TickerProviderStateMixin<WeeklyPage> {
  List<DailyItem> _dailyForecastItems = <DailyItem>[];

  static const _textSize = 12.0;

  @override
  void initState() {
    super.initState();

    final _oneCallApiWeather = ref.read(oneCallApiWeatherNotifierProvider);

    if (_oneCallApiWeather.weather != null) {
      _dailyForecastItems = generateDailyForecastItem(_oneCallApiWeather.weather!);
    }
  }

  ExpansionPanel _buildExpansionPanel(DailyItem dailyItem, ThemeData theme) {
    final weatherId = dailyItem.daily.weather?[0].id;

    return ExpansionPanel(
      canTapOnHeader: true,
      backgroundColor: theme.brightness == Brightness.dark ? dSecondaryDarkColor : lSecondaryLightColor,
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
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            StringUtils.capitalize(
                                "${WeatherDescriptionLocales(context).getWeatherDescription(weatherId!)}",
                                allWords: true),
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(fontSize: _textSize),
                          ),
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
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            "${AppLocalizations.of(context)!.translate("label_feels_like")} ${dailyItem.daily.feelsLike?.day}°C",
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(fontSize: _textSize),
                          ),
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
                color: theme.brightness == Brightness.dark ? dPrimaryBackgroundColor : lPrimaryBackgroundColor,
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
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          BoxedIcon(
                            WeatherIcons.humidity,
                            color: theme.focusColor,
                            size: 20.0,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      AppLocalizations.of(context)!.translate("label_humidity") ?? 'Humidity',
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                      style: const TextStyle(fontSize: _textSize),
                                    ),
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
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          BoxedIcon(
                            WeatherIcons.sunrise,
                            color: theme.focusColor,
                            size: 20.0,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      AppLocalizations.of(context)!.translate("label_uvi") ?? 'UV Index',
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                      style: const TextStyle(fontSize: _textSize),
                                    ),
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
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          WindIcon(
                            degree: num.parse("${dailyItem.daily.windDeg}"),
                            color: theme.iconTheme.color,
                            size: 24.0,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      AppLocalizations.of(context)!.translate("label_wind") ?? 'Wind',
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                      style: const TextStyle(fontSize: _textSize),
                                    ),
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
                          ),
                        ],
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
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            StringUtils.capitalize(
                                "${WeatherDescriptionLocales(context).getWeatherDescription(weatherId)}",
                                allWords: true),
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(fontSize: _textSize),
                          ),
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
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            "${AppLocalizations.of(context)!.translate("label_feels_like")} ${dailyItem.daily.feelsLike?.night}°C",
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(fontSize: _textSize),
                          ),
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
                color: theme.brightness == Brightness.dark ? dPrimaryBackgroundColor : lPrimaryBackgroundColor,
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
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          BoxedIcon(
                            WeatherIcons.humidity,
                            color: theme.focusColor,
                            size: 20.0,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      AppLocalizations.of(context)!.translate("label_humidity") ?? 'Humidity',
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                      style: const TextStyle(fontSize: _textSize),
                                    ),
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
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          BoxedIcon(
                            WeatherIcons.sunrise,
                            color: theme.focusColor,
                            size: 20.0,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      AppLocalizations.of(context)!.translate("label_uvi") ?? 'UV Index',
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                      style: const TextStyle(fontSize: _textSize),
                                    ),
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
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          WindIcon(
                            degree: num.parse("${dailyItem.daily.windDeg}"),
                            color: theme.iconTheme.color,
                            size: 24.0,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      AppLocalizations.of(context)!.translate("label_wind") ?? 'Wind',
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                      style: const TextStyle(fontSize: _textSize),
                                    ),
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
                          ),
                        ],
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
    final theme = themeProvider.getCurrentTheme();

    final internetConnected = ref.watch(connectionStateProvider);

    final oneCallApiWeather = ref.watch(oneCallApiWeatherNotifierProvider);

    final Color _titleColor = theme.brightness == Brightness.light ? lPrimaryTextColor : dPrimaryTextColor;

    // Reloads the weather data when connection is available
    if (internetConnected) {
      if (_dailyForecastItems.isEmpty) {
        ref.read(oneCallApiWeatherNotifierProvider).reloadWeather();

        if (oneCallApiWeather.weather != null) {
          _dailyForecastItems = generateDailyForecastItem(oneCallApiWeather.weather!);
        }
      }
    }

    if (internetConnected) {
      return _dailyForecastItems.isNotEmpty
          ? SingleChildScrollView(
              child: ExpansionPanelList(
                elevation: 3,
                animationDuration: const Duration(milliseconds: 600),
                expansionCallback: (index, isExpanded) {
                  setState(() {
                    _dailyForecastItems[index].isExpanded = isExpanded;
                  });
                },
                children: _dailyForecastItems.map((hourlyItem) => _buildExpansionPanel(hourlyItem, theme)).toList(),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            );
    } else {
      return const NoInternetConnection();
    }
  }

  List<DailyItem> generateDailyForecastItem(OpenWeatherMap openWeatherMap) {
    return List<DailyItem>.generate(
      openWeatherMap.daily!.length,
      (int index) {
        return DailyItem(
          daily: openWeatherMap.daily![index],
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
