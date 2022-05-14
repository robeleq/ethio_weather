import 'package:basic_utils/basic_utils.dart';
import 'package:ethio_weather/src/models/current_weather.dart';
import 'package:ethio_weather/src/models/daily_forecast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';

import '../locales/app_localizations.dart';
import '../providers/providers.dart';
import '../services/weather_description_locales.dart';

class CurrentWeatherCard extends ConsumerWidget {
  final CurrentWeather _currentWeather;
  final DailyForecast _todayWeather;

  const CurrentWeatherCard(this._currentWeather, this._todayWeather, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProvider = ref.watch(themeChangeNotifierProvider);
    final _theme = themeProvider.getCurrentTheme();

    final _userLocation = ref.watch(userLocationNotifierProvider);

    final _weatherId = _currentWeather.weather?[0].id;
    final _weatherIcon = _currentWeather.weather?[0].icon;

    const _textSize = 12.0;

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
                    children: <Widget>[
                      const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 24,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        _userLocation.userLocation.address,
                        style: const TextStyle(fontSize: 14.0),
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
                    padding: const EdgeInsets.all(4.0),
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
                              Image.asset(
                                'assets/images/icons/$_weatherIcon@2x.png',
                                height: 56,
                                width: 56,
                                fit: BoxFit.fitWidth,
                              ),
                              const SizedBox(
                                width: 1.0,
                              ),
                              Text(
                                "${_currentWeather.temp} °C",
                                style: const TextStyle(fontSize: 20.0),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text(
                                StringUtils.capitalize(
                                    "${WeatherDescriptionLocales(context).getWeatherDescription(_weatherId!)}",
                                    allWords: true),
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
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  "${AppLocalizations.of(context)!.translate("label_feels_like")} ${_currentWeather.feelsLike} °C",
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                  style: const TextStyle(fontSize: _textSize),
                                ),
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
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              AppLocalizations.of(context)!.translate("label_precipitation") ?? "Precipitation",
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              style: const TextStyle(fontSize: _textSize),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "${double.parse((_todayWeather.pop! * 100).toStringAsFixed(2))} %",
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
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              AppLocalizations.of(context)!.translate("label_humidity") ?? "Humidity",
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              style: const TextStyle(fontSize: _textSize),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "${_currentWeather.humidity} %",
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
                            degree: num.parse("${_currentWeather.windDeg}"),
                            color: _theme.iconTheme.color,
                            size: 24.0,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              AppLocalizations.of(context)!.translate("label_wind") ?? "Wind",
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              style: const TextStyle(fontSize: _textSize),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "${_currentWeather.windSpeed} m/s",
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
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              AppLocalizations.of(context)!.translate("label_pressure") ?? "Pressure",
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              style: const TextStyle(fontSize: _textSize),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "${_currentWeather.pressure} hPa",
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
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              AppLocalizations.of(context)!.translate("label_visibility") ?? "Visibility",
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              style: const TextStyle(fontSize: _textSize),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "${double.parse((_currentWeather.visibility! / 1000).toStringAsFixed(2))} km",
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
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              AppLocalizations.of(context)!.translate("label_uvi") ?? "UV Index",
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              style: const TextStyle(fontSize: _textSize),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "${_currentWeather.uvi}",
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
