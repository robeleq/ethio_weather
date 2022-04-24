import 'current_weather.dart';
import 'daily_forecast.dart';
import 'hourly_forecast.dart';

class OpenWeatherMap {
  double? lat;
  double? lon;
  String? timezone;
  int? timezoneOffset;
  CurrentWeather? current;
  List<HourlyForecast>? hourly;
  List<DailyForecast>? daily;

  OpenWeatherMap({this.lat, this.lon, this.timezone, this.timezoneOffset, this.current, this.hourly, this.daily});

  OpenWeatherMap.fromJson(Map<String, dynamic> json) {
    lat = json["lat"] is int ? (json['lat'] as int).toDouble() : json['lat'];
    lon = json["lon"] is int ? (json['lon'] as int).toDouble() : json['lon'];
    timezone = json['timezone'];
    timezoneOffset = json['timezone_offset'];
    current = json['current'] != null ? CurrentWeather.fromJson(json['current']) : null;
    if (json['hourly'] != null) {
      hourly = <HourlyForecast>[];
      json['hourly'].forEach((v) {
        hourly!.add(HourlyForecast.fromJson(v));
      });
    }
    if (json['daily'] != null) {
      daily = <DailyForecast>[];
      json['daily'].forEach((v) {
        daily!.add(DailyForecast.fromJson(v));
      });
    }
  }
}
