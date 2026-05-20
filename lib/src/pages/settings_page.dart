import 'dart:io';

import 'package:easy_audience_network/ad/banner_ad.dart';
import 'package:ethio_weather/src/config.dart';
import 'package:ethio_weather/src/pages/open_licenses_page.dart';
import 'package:ethio_weather/src/pages/privacy_page.dart';
import 'package:ethio_weather/src/utils/string_constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:workmanager/workmanager.dart';

import '../locales/app_locale.dart';
import '../locales/app_localizations.dart';
import '../models/open_weather_map.dart';
import '../providers/providers.dart';
import '../services/local_notification_service.dart';
import '../styles/colors.dart';
import '../styles/theme_scheme.dart';
import '../utils/lang_util.dart';
import '../widgets/labeled_radio.dart';
import '../widgets/settings_tile.dart';
import 'hourly_page.dart';

class SettingsPage extends ConsumerStatefulWidget {
  final String title;

  const SettingsPage({Key? key, required this.title}) : super(key: key);

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> with TickerProviderStateMixin<SettingsPage> {
  bool _isThemeDark = false;
  bool _isWeatherNotification = false;
  bool _expanded = false;

  final Map<String, String> languagesMap = appLocale.supportedLanguageMap;

  @override
  void initState() {
    super.initState();
  }

  _showLanguage(BuildContext context, ThemeData theme) {
    return showDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      context: context,
      builder: (BuildContext context) {
        final languageProvider = ref.read(languageNotifierProvider);

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
                      groupValue: languageProvider.currentLocale!.languageCode == e.key,
                      onChanged: (bool newValue) {
                        languageProvider.updateCurrentLocale(e.key);

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
    final theme = themeProvider.getCurrentTheme();

    final weatherNotificationProvider = ref.watch(weatherNotificationChangeNotifierProvider);
    final weatherNotification = weatherNotificationProvider.getShowWeatherNotification();

    final languageProvider = ref.watch(languageNotifierProvider);

    // final localNotificationService = ref.watch(localNotificationServiceProvider);

    final Color titleColor = theme.brightness == Brightness.light ? lPrimaryTextColor : dPrimaryTextColor;

    setState(() {
      _isThemeDark = Theme.of(context).brightness == Brightness.light ? false : true;
      _isWeatherNotification = weatherNotification;
    });

    return SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                    child: Container(
              padding: const EdgeInsets.all(16.0),
              color: theme.colorScheme.surface,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Language".toUpperCase(),
                    style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  SettingsTile(
                    title: 'Language',
                    subtitle: languageProvider.currentLocale?.language,
                    leading: Icon(
                      Icons.language,
                      color: theme.iconTheme.color,
                    ),
                    onTap: () => _showLanguage(context, theme),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "Theme".toUpperCase(),
                    style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  SettingsTile.switchTile(
                    title: "Dark Theme",
                    leading: Icon(
                      Icons.palette,
                      color: theme.iconTheme.color,
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
                    "Notifications".toUpperCase(),
                    style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  SettingsTile.switchTile(
                    title: "Hourly Weather Notifications",
                    leading: Icon(
                      Icons.palette,
                      color: theme.iconTheme.color,
                    ),
                    switchValue: _isWeatherNotification,
                    onToggle: (bool value) {
                      setState(() {
                        if (!value) {
                          _isWeatherNotification = false;
                          weatherNotificationProvider.setShowWeatherNotification(_isWeatherNotification);
                          // Cancel all the scheduled tasks
                          Workmanager().cancelAll();
                          ref.read(localNotificationServiceProvider).cancelAllNotifications();
                        } else {
                          _isWeatherNotification = true;
                          weatherNotificationProvider.setShowWeatherNotification(_isWeatherNotification);

                          // Schedule a notification at a specific time
                          // DateTime selectedTime = DateTime.now().add(const Duration(minutes: 2));
                          // ref.read(localNotificationServiceProvider).scheduleHourlyNotification(selectedTime);

                          // Schedule a hourly WorkManager Task
                          Workmanager().registerPeriodicTask(
                            "weather-notification-task",
                            "weatherLocalNotificationTask",
                            constraints: Constraints(
                              networkType: NetworkType.connected,
                            ),
                            frequency: const Duration(minutes: 20),
                            inputData: {
                              'appId': "fc39d687bb2ddba85f930d72cc93f5ea"
                            }
                          );

                          /*
                          Workmanager().registerOneOffTask(
                              "weather-notification-task", // A unique task identifier
                              "weatherLocalNotificationTask",
                              constraints: Constraints(
                                networkType: NetworkType.connected,
                              ),
                              initialDelay: const Duration(seconds: 20),
                              inputData: {
                                'appId': Config.appId
                              }
                          );
                          */
                        }
                      });
                    },
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "Unit".toUpperCase(),
                    style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
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
                                theme.brightness == Brightness.dark ? dSecondaryDarkColor : lSecondaryLightColor,
                            headerBuilder: (context, isExpanded) {
                              return ListTile(
                                title: Text(
                                  "${AppLocalizations.of(context)!.translate("label_weather_units")}",
                                  style: TextStyle(color: titleColor),
                                ),
                              );
                            },
                            body: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    "${AppLocalizations.of(context)!.translate("label_temp")}: °C",
                                    style: TextStyle(color: titleColor),
                                  ),
                                  leading: BoxedIcon(
                                    WeatherIcons.thermometer,
                                    color: theme.iconTheme.color,
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    "${AppLocalizations.of(context)!.translate("label_wind")}: m/s",
                                    style: TextStyle(color: titleColor),
                                  ),
                                  leading: WindIcon(
                                    degree: 90,
                                    color: theme.iconTheme.color,
                                    size: 24.0,
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    "${AppLocalizations.of(context)!.translate("label_pressure")}: hPa",
                                    style: TextStyle(color: titleColor),
                                  ),
                                  leading: BoxedIcon(
                                    WeatherIcons.barometer,
                                    color: theme.iconTheme.color,
                                    size: 24.0,
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    "${AppLocalizations.of(context)!.translate("label_precipitation")}: %",
                                    style: TextStyle(color: titleColor),
                                  ),
                                  leading: BoxedIcon(
                                    WeatherIcons.rain,
                                    color: theme.iconTheme.color,
                                    size: 24.0,
                                  ),
                                ),
                                ListTile(
                                  title: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      "${AppLocalizations.of(context)!.translate("label_time_format")}: 24-hour",
                                      style: TextStyle(color: titleColor),
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                  leading: BoxedIcon(
                                    WeatherIcons.time_3,
                                    color: theme.iconTheme.color,
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
                    style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  SettingsTile(
                    title: "Version",
                    leading: FaIcon(
                      FontAwesomeIcons.codeBranch,
                      color: theme.iconTheme.color,
                    ),
                    subtitle: StringConstant.appVersion,
                  ),
                  Divider(
                    color: theme.scaffoldBackgroundColor,
                    height: 1,
                  ),
                  SettingsTile(
                    title: "Share",
                    leading: Icon(
                      Icons.share,
                      color: theme.iconTheme.color,
                    ),
                    onTap: () {
                      Share.share(StringConstant.googlePlayStoreUrl, subject: "Install Ethio Weather App");
                    },
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "Privacy".toUpperCase(),
                    style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  SettingsTile(
                    title: "Terms of Use",
                    leading: Icon(
                      Icons.description,
                      color: theme.iconTheme.color,
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const PrivacyPage()));
                    },
                  ),
                  Divider(
                    color: theme.scaffoldBackgroundColor,
                    height: 1,
                  ),
                  SettingsTile(
                    title: "Open Source Licenses",
                    leading: Icon(
                      Icons.collections_bookmark,
                      color: theme.iconTheme.color,
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (BuildContext context) => const OpenLicensesPage()));
                    },
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
        ));
  }
}
