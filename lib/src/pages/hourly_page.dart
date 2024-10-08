import 'package:basic_utils/basic_utils.dart';
import 'package:ethio_weather/src/models/open_weather_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';

import '../locales/app_localizations.dart';
import '../models/hourly_forecast.dart';
import '../providers/providers.dart';
import '../services/weather_description_locales.dart';
import '../styles/colors.dart';
import '../widgets/no_internet_connection_card.dart';

class HourlyPage extends ConsumerStatefulWidget {
  final String title;

  const HourlyPage({Key? key, required this.title}) : super(key: key);

  @override
  ConsumerState<HourlyPage> createState() => _HourlyPageState();
}

class _HourlyPageState extends ConsumerState<HourlyPage> with TickerProviderStateMixin<HourlyPage> {
  List<HourlyItem> _hourlyItems = <HourlyItem>[];

  static const _textSize = 12.0;

  @override
  void initState() {
    super.initState();

    final _oneCallApiWeather = ref.read(oneCallApiWeatherNotifierProvider);

    if (_oneCallApiWeather.weather != null) {
      _hourlyItems = generateHourlyForecastItem(_oneCallApiWeather.weather!);
    }
  }

  ExpansionPanel _buildExpansionPanel(HourlyItem hourlyItem, ThemeData theme) {
    final weatherId = hourlyItem.hourly.weather?[0].id;

    return ExpansionPanel(
      canTapOnHeader: true,
      backgroundColor: theme.brightness == Brightness.dark ? dSecondaryDarkColor : lSecondaryLightColor,
      headerBuilder: (context, isExpanded) {
        return Container(
            decoration: const BoxDecoration(color: Colors.transparent),
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(hourlyItem.hourly.dt! * 1000)),
                      style: const TextStyle(fontSize: 14.0),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "${hourlyItem.hourly.temp}°C",
                      style: const TextStyle(fontSize: 14.0),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Image.asset(
                      'assets/images/icons/${hourlyItem.hourly.weather?[0].icon}@2x.png',
                      height: 48,
                      width: 48,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "${hourlyItem.hourly.humidity}%",
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
            padding: const EdgeInsets.only(left: 16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                  StringUtils.capitalize("${WeatherDescriptionLocales(context).getWeatherDescription(weatherId!)}",
                      allWords: true),
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: Colors.black,
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
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            BoxedIcon(
                              WeatherIcons.thermometer,
                              color: theme.iconTheme.color,
                              size: 24.0,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      AppLocalizations.of(context)!.translate("label_feels_like") ?? 'Feels Like',
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                      style: const TextStyle(fontSize: _textSize),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    "${hourlyItem.hourly.feelsLike}°C",
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
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            WindIcon(
                              degree: num.parse("${hourlyItem.hourly.windDeg}"),
                              color: theme.iconTheme.color,
                              size: 24.0,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
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
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    "${hourlyItem.hourly.windSpeed} m/s",
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
                const Divider(height: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            BoxedIcon(
                              WeatherIcons.humidity,
                              color: theme.iconTheme.color,
                              size: 24.0,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
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
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    "${hourlyItem.hourly.humidity} %",
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
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            BoxedIcon(
                              WeatherIcons.sunrise,
                              color: theme.iconTheme.color,
                              size: 24.0,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
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
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    "${hourlyItem.hourly.uvi}",
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
      isExpanded: hourlyItem.isExpanded,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = ref.watch(themeChangeNotifierProvider);
    final theme = themeProvider.getCurrentTheme();

    final internetConnected = ref.watch(connectionStateProvider);

    final Color _titleColor = theme.brightness == Brightness.light ? lPrimaryTextColor : dPrimaryTextColor;

    final hoursFromNow = DateTime.now().add(const Duration(hours: 11));
    final unixTimestampHoursFromNow = hoursFromNow.toUtc().millisecondsSinceEpoch;

    final oneCallApiWeather = ref.watch(oneCallApiWeatherNotifierProvider);

    // Reloads the weather data when connection is available
    if (internetConnected) {
      if (_hourlyItems.isEmpty) {
        ref.read(oneCallApiWeatherNotifierProvider).reloadWeather();

        if (oneCallApiWeather.weather != null) {
          _hourlyItems = generateHourlyForecastItem(oneCallApiWeather.weather!);
        }
      }
    }

    if (internetConnected) {
      return _hourlyItems.isNotEmpty
          ? SingleChildScrollView(
              child: ExpansionPanelList(
                elevation: 3,
                animationDuration: const Duration(milliseconds: 600),
                expansionCallback: (index, isExpanded) {
                  setState(() {
                    _hourlyItems[index].isExpanded = isExpanded;
                  });
                },
                children: _hourlyItems
                    .where((hourlyItem) => ((hourlyItem.hourly.dt! * 1000) < unixTimestampHoursFromNow))
                    .map((hourlyItem) => _buildExpansionPanel(hourlyItem, theme))
                    .toList(),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            );
    } else {
      return const NoInternetConnection();
    }
  }

  List<HourlyItem> generateHourlyForecastItem(OpenWeatherMap openWeatherMap) {
    return List<HourlyItem>.generate(
      openWeatherMap.hourly!.length,
      (int index) {
        return HourlyItem(
          hourly: openWeatherMap.hourly![index],
        );
      },
    );
  }
}

// stores ExpansionPanel state information
class HourlyItem {
  HourlyItem({
    required this.hourly,
    this.isExpanded = false,
  });

  HourlyForecast hourly;
  bool isExpanded;
}
