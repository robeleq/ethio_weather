import 'package:flutter/material.dart';

import '../locales/app_localizations.dart';

class WeatherDescriptionLocales {
  BuildContext context;
  late final Map<int, String> weatherDescription;

  WeatherDescriptionLocales(this.context) {
    weatherDescription = {
      500: AppLocalizations.of(context)!.translate("rain_label_light") ?? "light rain",
      501: AppLocalizations.of(context)!.translate("rain_label_moderate") ?? "moderate rain",
      502: AppLocalizations.of(context)!.translate("rain_label_heavy_intensity") ?? "heavy intensity rain",
      503: AppLocalizations.of(context)!.translate("rain_label_very_heavy") ?? "very heavy rain",
      504: AppLocalizations.of(context)!.translate("rain_label_extreme") ?? "extreme rain",
      511: AppLocalizations.of(context)!.translate("rain_label_freezing") ?? "freezing rain",
      520:
          AppLocalizations.of(context)!.translate("rain_label_light_intensity shower") ?? "light intensity shower rain",
      521: AppLocalizations.of(context)!.translate("rain_label_shower") ?? "shower rain",
      522:
          AppLocalizations.of(context)!.translate("rain_label_heavy_intensity_shower") ?? "heavy intensity shower rain",
      531: AppLocalizations.of(context)!.translate("rain_label_ragged_shower") ?? "ragged shower rain",
      800: AppLocalizations.of(context)!.translate("sky_label_clear_sky") ?? "clear sky",
      801: AppLocalizations.of(context)!.translate("cloud_label_few_clouds") ?? "few clouds",
      802: AppLocalizations.of(context)!.translate("cloud_label_scattered_clouds") ?? "scattered clouds",
      803: AppLocalizations.of(context)!.translate("cloud_label_broken_clouds") ?? "broken clouds",
      804: AppLocalizations.of(context)!.translate("cloud_label_overcast_clouds") ?? "overcast clouds",
      200: AppLocalizations.of(context)!.translate("thunderstorm_label_with_light_rain") ??
          "thunderstorm with light rain",
      201: AppLocalizations.of(context)!.translate("thunderstorm_label_with_rain") ?? "thunderstorm with rain",
      202: AppLocalizations.of(context)!.translate("thunderstorm_label_with_heavy_rain") ??
          "thunderstorm with heavy rain",
      210: AppLocalizations.of(context)!.translate("thunderstorm_label_light") ?? "thunderstorm light",
      211: AppLocalizations.of(context)!.translate("thunderstorm_label_thunderstorm") ?? "thunderstorm",
      212: AppLocalizations.of(context)!.translate("thunderstorm_label_heavy") ?? "thunderstorm heavy ",
      221: AppLocalizations.of(context)!.translate("thunderstorm_label_ragged") ?? "thunderstorm ragged",
      230: AppLocalizations.of(context)!.translate("thunderstorm_label_with_light_drizzle") ??
          "thunderstorm with light drizzle",
      231: AppLocalizations.of(context)!.translate("thunderstorm_label_with_drizzle") ?? "thunderstorm with drizzle",
      232: AppLocalizations.of(context)!.translate("thunderstorm_label_with_heavy_drizzle") ??
          "thunderstorm with heavy drizzle",
      300: AppLocalizations.of(context)!.translate("drizzle_label_light_intensity") ?? "light intensity drizzle",
      301: AppLocalizations.of(context)!.translate("drizzle_label_drizzle") ?? "drizzle",
      302: AppLocalizations.of(context)!.translate("drizzle_label_heavy_intensity") ?? "heavy intensity drizzle",
      310: AppLocalizations.of(context)!.translate("drizzle_label_light_intensity_rain") ??
          "light intensity drizzle rain",
      311: AppLocalizations.of(context)!.translate("drizzle_label_rain") ?? "drizzle rain",
      312: AppLocalizations.of(context)!.translate("drizzle_label_heavy_intensity_rain") ??
          "heavy intensity drizzle rain",
      313: AppLocalizations.of(context)!.translate("drizzle_label_shower_rain") ?? "shower rain and drizzle",
      314:
          AppLocalizations.of(context)!.translate("drizzle_label_heavy_shower_rain") ?? "heavy shower rain and drizzle",
      321: AppLocalizations.of(context)!.translate("drizzle_label_shower") ?? "shower drizzle",
      600: AppLocalizations.of(context)!.translate("snow_label_light_snow") ?? "light snow",
      601: AppLocalizations.of(context)!.translate("snow_label_snow") ?? "snow",
      602: AppLocalizations.of(context)!.translate("snow_label_heavy_snow") ?? "heavy snow",
      611: AppLocalizations.of(context)!.translate("snow_label_sleet") ?? "sleet",
      612: AppLocalizations.of(context)!.translate("snow_label_light_shower_sleet") ?? "light shower sleet",
      613: AppLocalizations.of(context)!.translate("snow_label_shower_sleet") ?? "shower sleet",
      615: AppLocalizations.of(context)!.translate("snow_label_light_rain_and_snow") ?? "light rain and snow",
      616: AppLocalizations.of(context)!.translate("snow_label_rain_and_snow") ?? "rain and snow",
      620: AppLocalizations.of(context)!.translate("snow_label_light_shower_snow") ?? "light shower snow",
      621: AppLocalizations.of(context)!.translate("snow_label_shower_snow") ?? "shower snow",
      622: AppLocalizations.of(context)!.translate("snow_label_heavy_shower_snow") ?? "heavy shower snow",
      701: AppLocalizations.of(context)!.translate("atmosphere_label_mist") ?? "mist",
      711: AppLocalizations.of(context)!.translate("atmosphere_label_smoke") ?? "smoke",
      721: AppLocalizations.of(context)!.translate("atmosphere_label_haze") ?? "haze",
      731: AppLocalizations.of(context)!.translate("atmosphere_label_dust_whirls") ?? "dust whirls",
      741: AppLocalizations.of(context)!.translate("atmosphere_label_fog") ?? "fog",
      751: AppLocalizations.of(context)!.translate("atmosphere_label_sand") ?? "sand",
      761: AppLocalizations.of(context)!.translate("atmosphere_label_dust") ?? "dust",
      762: AppLocalizations.of(context)!.translate("atmosphere_label_volcanic_ash") ?? "volcanic ash",
      771: AppLocalizations.of(context)!.translate("atmosphere_label_squalls") ?? "squalls",
      781: AppLocalizations.of(context)!.translate("atmosphere_label_tornado") ?? "tornado",
    };
  }

  String? getWeatherDescription(int weatherId) {
    return weatherDescription[weatherId];
  }
}
