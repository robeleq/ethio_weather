import 'dart:io';

import 'package:easy_audience_network/easy_audience_network.dart';
import 'package:ethio_weather/src/utils/string_constant.dart';
import 'package:ethio_weather/src/widgets/hourly_fromnow_weather_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final theme = themeProvider.getCurrentTheme();

    final internetConnected = ref.watch(connectionStateProvider);

    final oneCallApiWeather = ref.watch(oneCallApiWeatherNotifierProvider);

    // Reload weather data when connection is available
    ref.listen<bool>(connectionStateProvider, (previous, next) {
      if (next) {
        if (oneCallApiWeather.weather == null) {
          ref.read(oneCallApiWeatherNotifierProvider).reloadWeather();
        }
      }
    });

    final hoursFromNow = DateTime.now().add(const Duration(hours: 4));
    final unixTimestampHoursFromNow = hoursFromNow.toUtc().millisecondsSinceEpoch;

    return internetConnected
        ? Stack(
      children: <Widget>[
        (oneCallApiWeather.weather != null)
            ? Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                  child: Column(
                    children: [
                      CurrentWeatherCard(
                        oneCallApiWeather.weather!.current!,
                        oneCallApiWeather.weather!.daily![0],
                      ),
                      HourlyFromNowWeatherCard(
                        oneCallApiWeather.weather!.hourly,
                        unixTimestampHoursFromNow,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: BannerAd(
                placementId: Platform.isAndroid
                    ? StringConstant.bannerPlacementID
                    : "",
                bannerSize: BannerSize.STANDARD,
              ),
            ),
          ],
        )
            : const Center(
          child: CircularProgressIndicator(),
        ),
      ],
    )
        : const NoInternetConnection();

  }
}
