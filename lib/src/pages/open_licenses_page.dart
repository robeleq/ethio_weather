import 'package:ethio_weather/src/utils/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/providers.dart';
import '../styles/colors.dart';

class OpenLicensesPage extends ConsumerWidget {
  const OpenLicensesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProvider = ref.watch(themeChangeNotifierProvider);
    final _theme = themeProvider.getCurrentTheme();

    final Color _color = _theme.brightness == Brightness.light ? Colors.black : Colors.white;

    final Color _titleColor = _theme.brightness == Brightness.light ? lPrimaryTextColor : dPrimaryTextColor;

    final kActiveShadowColor = const Color(0xFF4056C6).withOpacity(.15);

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.close, color: _color),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Column(
              children: [
                Image.asset(
                  'assets/images/ic_launcher.png',
                  height: 56,
                  width: 56,
                  fit: BoxFit.fitWidth,
                ),
                Text(
                  StringConstant.appName,
                ),
                Text(
                  StringConstant.appVersion,
                ),
              ],
            ),
            Card(
              elevation: 8.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Text(StringConstant.appShortDescription),
              ),
            ),
            Card(
              elevation: 8.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Column(children: [
                  Text(
                    StringConstant.appDesignedandDevelopedBy,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  Column(
                    children: StringConstant.appDevelopers
                        .map(
                          (developer) => Text(
                            developer,
                          ),
                        )
                        .toList(),
                  ),
                ]),
              ),
            ),
            Card(
              elevation: 8.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Column(children: [
                  const Text(
                    StringConstant.appOtherContributors,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  Column(
                    children: StringConstant.appContributors
                        .map(
                          (contributor) => Text(
                            contributor,
                          ),
                        )
                        .toList(),
                  ),
                ]),
              ),
            ),
            Card(
              elevation: 8.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "1. Open Weather.",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    Text(StringConstant.openWeatherDesc),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
