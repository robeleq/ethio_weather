import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_icons/weather_icons.dart';

import '../locales/app_locale.dart';
import '../locales/app_localizations.dart';
import '../providers/providers.dart';
import '../styles/colors.dart';
import '../styles/theme_scheme.dart';
import '../utils/lang_util.dart';
import '../widgets/labeled_radio.dart';
import '../widgets/settings_tile.dart';

class SettingsPage extends ConsumerStatefulWidget {
  final String title;

  const SettingsPage({Key? key, required this.title}) : super(key: key);

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> with TickerProviderStateMixin<SettingsPage> {
  bool _isThemeDark = false;
  bool _expanded = false;

  final Map<String, String> languagesMap = appLocale.supportedLanguageMap;

  _showLanguage(BuildContext context, ThemeData theme) {
    return showDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      context: context,
      builder: (BuildContext context) {
        final _languageProvider = ref.read(languageNotifierProvider);

        return AlertDialog(
          backgroundColor: theme.brightness == Brightness.light ? lSecondaryLightColor : dSecondaryDarkColor,
          title: const Text('Select Language'),
          content: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: <LabeledRadio>[
                  for (MapEntry<String, String> e in languagesMap.entries)
                    LabeledRadio(
                      label: e.value,
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      value: true,
                      groupValue: _languageProvider.currentLocale!.languageCode == e.key,
                      onChanged: (bool newValue) {
                        _languageProvider.updateCurrentLocale(e.key);

                        if (kDebugMode) {
                          print(e.key);
                        }

                        Locale locale = Locale(e.key);

                        appLocale.onLocaleChanged!(locale);

                        LangUtil.saveLanguageCodeToSharedPref(locale);

                        Navigator.of(context).pop();
                      },
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = ref.watch(themeChangeNotifierProvider);
    final _theme = themeProvider.getCurrentTheme();

    final Color _titleColor = _theme.brightness == Brightness.light ? lPrimaryTextColor : dPrimaryTextColor;

    final languageProvider = ref.watch(languageNotifierProvider);

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
              subtitle: languageProvider.currentLocale?.language,
              leading: Icon(
                Icons.language,
                color: _theme.iconTheme.color,
              ),
              onTap: () => _showLanguage(context, _theme),
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
            Card(
              elevation: 4.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.transparent),
                child: ExpansionPanelList(
                  expandedHeaderPadding: EdgeInsets.zero,
                  expansionCallback: (panelIndex, isExpanded) {
                    _expanded = !_expanded;
                    setState(() {});
                  },
                  children: [
                    ExpansionPanel(
                      backgroundColor:
                          _theme.brightness == Brightness.dark ? dSecondaryDarkColor : lSecondaryLightColor,
                      headerBuilder: (context, isExpanded) {
                        return ListTile(
                          title: Text(
                            "${AppLocalizations.of(context)!.translate("label_weather_units")}",
                            style: TextStyle(color: _titleColor),
                          ),
                        );
                      },
                      body: Column(
                        children: [
                          ListTile(
                            title: Text(
                              "${AppLocalizations.of(context)!.translate("label_temp")}: °C",
                              style: TextStyle(color: _titleColor),
                            ),
                            leading: BoxedIcon(
                              WeatherIcons.thermometer,
                              color: _theme.iconTheme.color,
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "${AppLocalizations.of(context)!.translate("label_wind")}: m/s",
                              style: TextStyle(color: _titleColor),
                            ),
                            leading: WindIcon(
                              degree: 90,
                              color: _theme.iconTheme.color,
                              size: 24.0,
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "${AppLocalizations.of(context)!.translate("label_pressure")}: hPa",
                              style: TextStyle(color: _titleColor),
                            ),
                            leading: BoxedIcon(
                              WeatherIcons.barometer,
                              color: _theme.iconTheme.color,
                              size: 24.0,
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "${AppLocalizations.of(context)!.translate("label_precipitation")}: %",
                              style: TextStyle(color: _titleColor),
                            ),
                            leading: BoxedIcon(
                              WeatherIcons.rain,
                              color: _theme.iconTheme.color,
                              size: 24.0,
                            ),
                          ),
                          ListTile(
                            title: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                "${AppLocalizations.of(context)!.translate("label_time_format")}: 24-hour",
                                style: TextStyle(color: _titleColor),
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                            leading: BoxedIcon(
                              WeatherIcons.time_3,
                              color: _theme.iconTheme.color,
                              size: 24.0,
                            ),
                          ),
                        ],
                      ),
                      isExpanded: _expanded,
                      canTapOnHeader: true,
                    )
                  ],
                ),
              ),
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
