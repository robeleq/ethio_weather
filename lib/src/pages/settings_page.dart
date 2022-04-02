import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_icons/weather_icons.dart';

import '../styles/colors.dart';
import '../widgets/settings_tile.dart';

class SettingsPage extends StatefulWidget {
  final String title;

  const SettingsPage({Key? key, required this.title}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with TickerProviderStateMixin<SettingsPage> {
  final String _selectedLanguage = "English";
  bool _isThemeDark = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Color _backgroundColor = _theme.brightness == Brightness.light ? primaryLightColor : secondaryLightColor;
    final Color _textColor = _theme.brightness == Brightness.light ? Colors.black : Colors.white;
    final Color _subtitleColor = _theme.brightness == Brightness.light ? Colors.black54 : Colors.white60;

    return SafeArea(
        child: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Language".toUpperCase(),
              style: _theme.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 8.0,
            ),
            SettingsTile(
              title: 'Language',
              subtitle: _selectedLanguage,
              leading: Icon(
                Icons.language,
                color: _textColor,
              ),
              onTap: () {},
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              "Theme".toUpperCase(),
              style: _theme.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 8.0,
            ),
            SettingsTile.switchTile(
              title: "Dark Theme",
              leading: Icon(
                Icons.palette,
                color: _textColor,
              ),
              switchValue: _isThemeDark,
              onToggle: (bool value) {
                setState(() {
                  if (!value) {
                    _isThemeDark = false;
                  } else {
                    _isThemeDark = true;
                  }
                });
              },
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              "Units".toUpperCase(),
              style: _theme.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 8.0,
            ),
            SettingsTile(
              title: 'Temp',
              subtitle: "°C",
              leading: BoxedIcon(
                WeatherIcons.thermometer,
                color: _textColor,
              ),
              onTap: () {},
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              "About".toUpperCase(),
              style: _theme.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 8.0,
            ),
            SettingsTile(
              title: "Version",
              leading: FaIcon(FontAwesomeIcons.codeBranch, color: _textColor),
              subtitle: "v0.0.1",
            ),
            Divider(
              color: _theme.scaffoldBackgroundColor,
              height: 1,
            ),
            SettingsTile(
              title: "Share",
              leading: Icon(
                Icons.share,
                color: _textColor,
              ),
              onTap: () {},
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              "Privacy".toUpperCase(),
              style: _theme.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 8.0,
            ),
            SettingsTile(
              title: "Terms of Use",
              leading: Icon(
                Icons.description,
                color: _textColor,
              ),
              onTap: () {},
            ),
            Divider(
              color: _theme.scaffoldBackgroundColor,
              height: 1,
            ),
            SettingsTile(
              title: "Open Source Licenses",
              leading: Icon(
                Icons.collections_bookmark,
                color: _textColor,
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    ));
  }
}
