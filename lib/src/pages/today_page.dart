import 'package:ethio_weather/src/widgets/hourly_fromnow_weather_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

    final hoursFromNow = DateTime.now().add(const Duration(hours: 4));
    final unixTimestampHoursFromNow = hoursFromNow.toUtc().millisecondsSinceEpoch;

    return Stack(children: <Widget>[
      /*Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/images/photo_addis_ababa.jpg"),
          ),
        ),
      ),*/
      _openWeatherMapData.when(
        data: (_data) => SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 8.0, bottom: 16.0),
            child: Column(
              children: [
                CurrentWeatherCard(_data.current!, _data.daily![0]),
                HourlyFromNowWeatherCard(_data.hourly, unixTimestampHoursFromNow),
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
