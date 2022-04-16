import 'package:ethio_weather/src/models/hourly_forecast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';

import '../providers/providers.dart';

class HourlyFromNowWeatherCard extends ConsumerWidget {
  final List<HourlyForecast>? _hourlyForecast;
  final int? _hoursFromNow;

  const HourlyFromNowWeatherCard(this._hourlyForecast, this._hoursFromNow, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProvider = ref.watch(themeChangeNotifierProvider);
    final _theme = themeProvider.getCurrentTheme();

    return Container(
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
              ..._hourlyForecast!.map((element) => ((element.dt! * 1000) < _hoursFromNow!)
                  ? Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(element.dt! * 1000)),
                            style: const TextStyle(fontSize: 12.0),
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
                          Text(
                            "${element.temp}°C",
                            style: const TextStyle(fontSize: 12.0),
                          ),
                          const SizedBox(
                            height: 4.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const BoxedIcon(
                                WeatherIcons.humidity,
                                color: Colors.blueAccent,
                                size: 10.0,
                              ),
                              Text(
                                "${element.humidity}%",
                                style: const TextStyle(fontSize: 12.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Container())
            ],
          ),
        ),
      ),
    );
  }
}
