import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';

import '../models/hourly_forecast.dart';
import '../providers/providers.dart';
import '../styles/colors.dart';

class HourlyPage extends ConsumerStatefulWidget {
  final String title;

  const HourlyPage({Key? key, required this.title}) : super(key: key);

  @override
  ConsumerState<HourlyPage> createState() => _HourlyPageState();
}

class _HourlyPageState extends ConsumerState<HourlyPage> with TickerProviderStateMixin<HourlyPage> {
  List<HourlyItem> _hourlyItems = <HourlyItem>[];

  @override
  void initState() {
    super.initState();

    final _openWeatherMapData = ref.read(openWeatherMapDataProvider);

    _openWeatherMapData.whenData(
      (value) => _hourlyItems = List<HourlyItem>.generate(
        value.hourly!.length,
        (int index) {
          return HourlyItem(
            hourly: value.hourly![index],
          );
        },
      ),
    );
  }

  ExpansionPanel _buildExpansionPanel(HourlyItem hourlyItem, ThemeData _theme) {
    return ExpansionPanel(
      canTapOnHeader: true,
      headerBuilder: (context, isExpanded) {
        return Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
            child: Text(StringUtils.capitalize("${hourlyItem.hourly.weather?[0].description}", allWords: true),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                            const BoxedIcon(
                              WeatherIcons.thermometer,
                              color: Colors.blueAccent,
                              size: 24.0,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    'Feels Like',
                                    style: TextStyle(fontSize: 14),
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
                              color: _theme.iconTheme.color,
                              size: 24.0,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    'Wind',
                                    style: TextStyle(fontSize: 14),
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
                            const BoxedIcon(
                              WeatherIcons.humidity,
                              color: Colors.blueAccent,
                              size: 24.0,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    'Humidity',
                                    style: TextStyle(fontSize: 14),
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
                            const BoxedIcon(
                              WeatherIcons.sunrise,
                              color: Colors.blueAccent,
                              size: 24.0,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    'UV Index',
                                    style: TextStyle(fontSize: 14),
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
    final _theme = themeProvider.getCurrentTheme();

    final Color _titleColor = _theme.brightness == Brightness.light ? lPrimaryTextColor : dPrimaryTextColor;

    if (_hourlyItems.isNotEmpty) {
      return SingleChildScrollView(
        child: ExpansionPanelList(
          elevation: 3,
          animationDuration: const Duration(milliseconds: 600),
          expansionCallback: (index, isExpanded) {
            setState(() {
              _hourlyItems[index].isExpanded = !isExpanded;
            });
          },
          children: _hourlyItems.map((hourlyItem) => _buildExpansionPanel(hourlyItem, _theme)).toList(),
        ),
      );
    } else {
      return const CircularProgressIndicator(); // loading
    }
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
