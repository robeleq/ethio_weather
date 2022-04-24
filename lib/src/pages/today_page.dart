import 'package:ethio_weather/src/widgets/hourly_fromnow_weather_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config.dart';
import '../providers/providers.dart';
import '../styles/colors.dart';
import '../widgets/current_weather_card.dart';
import '../widgets/no_internet_connection_card.dart';

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

    final _openWeatherMap = ref.watch(openWeatherMapNotifierProvider);

    final _internetConnected = ref.watch(connectionStateProvider);

    // Reload weather data when connection is available
    if (_internetConnected) {
      if (_openWeatherMap.current != null && _openWeatherMap.hourly != null && _openWeatherMap.daily != null) {
        ref.read(openWeatherMapNotifierProvider.notifier).getWeather(Config.apiOneCallUrl.toString());
      }
    }

    final hoursFromNow = DateTime.now().add(const Duration(hours: 4));
    final unixTimestampHoursFromNow = hoursFromNow.toUtc().millisecondsSinceEpoch;

    return _internetConnected
        ? Stack(children: <Widget>[
            (_openWeatherMap.current != null && _openWeatherMap.hourly != null && _openWeatherMap.daily != null)
                ? SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                      child: Column(
                        children: [
                          CurrentWeatherCard(_openWeatherMap.current!, _openWeatherMap.daily![0]),
                          HourlyFromNowWeatherCard(_openWeatherMap.hourly, unixTimestampHoursFromNow),
                        ],
                      ),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ])
        : const NoInternetConnection();
  }
}
