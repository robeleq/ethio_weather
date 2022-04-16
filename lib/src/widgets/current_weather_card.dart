import 'package:basic_utils/basic_utils.dart';
import 'package:ethio_weather/src/models/current_weather.dart';
import 'package:ethio_weather/src/models/daily_forecast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';

import '../providers/providers.dart';

class CurrentWeatherCard extends ConsumerWidget {
  final CurrentWeather _currentWeather;
  final DailyForecast _todayWeather;

  const CurrentWeatherCard(this._currentWeather, this._todayWeather, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProvider = ref.watch(themeChangeNotifierProvider);
    final _theme = themeProvider.getCurrentTheme();

    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(color: Colors.transparent),
          margin: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Card(
            elevation: 8.0,
            margin: const EdgeInsets.all(8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const <Widget>[
                      Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 24,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        'Time Zone: Addis_Ababa',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    DateFormat('EEE, dd/MM/yyyy, hh:mm a')
                        .format(DateTime.fromMillisecondsSinceEpoch(_currentWeather.dt! * 1000)),
                    style: const TextStyle(fontSize: 12.0),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 6,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              BoxedIcon(
                                WeatherIcons.day_cloudy,
                                color: _theme.iconTheme.color,
                                size: 32.0,
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                "${_currentWeather.temp} °C",
                                style: const TextStyle(fontSize: 24.0),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                StringUtils.capitalize("${_currentWeather.weather?[0].description}", allWords: true),
                                style: const TextStyle(fontSize: 12.0),
                              ),
                              const SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                "${_todayWeather.temp?.min} °C / ${_todayWeather.temp?.max} °C",
                                style: const TextStyle(fontSize: 12.0),
                              ),
                              const SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                "Feels like ${_currentWeather.feelsLike} °C",
                                style: const TextStyle(fontSize: 12.0),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                  margin: const EdgeInsets.only(right: 8.0),
                  child: Card(
                    elevation: 8.0,
                    margin: const EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          BoxedIcon(
                            WeatherIcons.rain,
                            color: _theme.iconTheme.color,
                            size: 24.0,
                          ),
                          const Text(
                            "Precipitation",
                            style: TextStyle(fontSize: 11.0),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "${_todayWeather.pop! * 100}",
                            style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: Card(
                    elevation: 8.0,
                    margin: const EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          BoxedIcon(
                            WeatherIcons.humidity,
                            color: _theme.iconTheme.color,
                            size: 24.0,
                          ),
                          const Text(
                            "Humidity",
                            style: TextStyle(fontSize: 11.0),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "${_todayWeather.humidity} %",
                            style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                  margin: const EdgeInsets.only(left: 8.0),
                  child: Card(
                    elevation: 8.0,
                    margin: const EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          WindIcon(
                            degree: num.parse("${_todayWeather.windDeg}"),
                            color: _theme.iconTheme.color,
                            size: 24.0,
                          ),
                          const Text(
                            "Wind",
                            style: TextStyle(fontSize: 11.0),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "${_todayWeather.windSpeed} m/s",
                            style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                  margin: const EdgeInsets.only(right: 8.0),
                  child: Card(
                    elevation: 8.0,
                    margin: const EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          BoxedIcon(
                            WeatherIcons.barometer,
                            color: _theme.iconTheme.color,
                            size: 24.0,
                          ),
                          const Text(
                            "Pressure",
                            style: TextStyle(fontSize: 11.0),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "${_todayWeather.pressure} hPa",
                            style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: Card(
                    elevation: 8.0,
                    margin: const EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          FaIcon(
                            FontAwesomeIcons.eye,
                            color: _theme.iconTheme.color,
                            size: 28.0,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            "Visibility",
                            style: TextStyle(fontSize: 11.0),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "${_currentWeather.visibility! / 1000} km",
                            style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                  margin: const EdgeInsets.only(left: 8.0),
                  child: Card(
                    elevation: 8.0,
                    margin: const EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          BoxedIcon(
                            WeatherIcons.sunrise,
                            color: _theme.iconTheme.color,
                            size: 24.0,
                          ),
                          const Text(
                            "UV Index",
                            style: TextStyle(
                              fontSize: 11.0,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "${_todayWeather.uvi}",
                            style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
