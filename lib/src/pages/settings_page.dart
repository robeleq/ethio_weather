import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_icons/weather_icons.dart';

import '../providers/providers.dart';
import '../styles/colors.dart';
import '../styles/theme_scheme.dart';
import '../widgets/settings_tile.dart';

class SettingsPage extends ConsumerStatefulWidget {
  final String title;

  const SettingsPage({Key? key, required this.title}) : super(key: key);

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> with TickerProviderStateMixin<SettingsPage> {
  final String _selectedLanguage = "English";
  bool _isThemeDark = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = ref.watch(themeChangeNotifierProvider);
    final _theme = themeProvider.getCurrentTheme();

    final Color _titleColor = _theme.brightness == Brightness.light ? lPrimaryTextColor : dPrimaryTextColor;

    setState(() {
      _isThemeDark = Theme.of(context).brightness == Brightness.light ? false : true;
    });

    return SafeArea(
        child: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        color: _theme.backgroundColor,
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
                color: _theme.iconTheme.color,
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
                color: _theme.iconTheme.color,
              ),
              switchValue: _isThemeDark,
              onToggle: (bool value) {
                setState(() {
                  if (!value) {
                    _isThemeDark = false;
                    themeProvider.setTheme(ThemeScheme.lightTheme());
                  } else {
                    _isThemeDark = true;
                    themeProvider.setTheme(ThemeScheme.darkTheme());
                  }
                });
              },
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              "Unit".toUpperCase(),
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
                color: _theme.iconTheme.color,
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
              leading: FaIcon(
                FontAwesomeIcons.codeBranch,
                color: _theme.iconTheme.color,
              ),
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
                color: _theme.iconTheme.color,
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
                color: _theme.iconTheme.color,
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
                color: _theme.iconTheme.color,
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    ));
  }
}
