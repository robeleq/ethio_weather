import 'rain.dart';
import 'weather.dart';

class HourlyForecast {
  int? dt;
  double? temp;
  double? feelsLike;
  int? pressure;
  int? humidity;
  double? dewPoint;
  double? uvi;
  int? clouds;
  int? visibility;
  double? windSpeed;
  int? windDeg;
  double? windGust;
  List<Weather>? weather;
  double? pop;
  Rain? rain;

  HourlyForecast(
      {this.dt,
      this.temp,
      this.feelsLike,
      this.pressure,
      this.humidity,
      this.dewPoint,
      this.uvi,
      this.clouds,
      this.visibility,
      this.windSpeed,
      this.windDeg,
      this.windGust,
      this.weather,
      this.pop,
      this.rain});

  HourlyForecast.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    temp = json["temp"] is int ? (json['temp'] as int).toDouble() : json['temp'];
    feelsLike = json["feels_like"] is int ? (json['feels_like'] as int).toDouble() : json['feels_like'];
    pressure = json['pressure'];
    humidity = json['humidity'];
    dewPoint = json["dew_point"] is int ? (json['dew_point'] as int).toDouble() : json['dew_point'];
    uvi = json["uvi"] is int ? (json['uvi'] as int).toDouble() : json['uvi'];
    clouds = json['clouds'];
    visibility = json['visibility'];
    windSpeed = json["wind_speed"] is int ? (json['wind_speed'] as int).toDouble() : json['wind_speed'];
    windDeg = json['wind_deg'];
    windGust = json["wind_gust"] is int ? (json['wind_gust'] as int).toDouble() : json['wind_gust'];
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather!.add(Weather.fromJson(v));
      });
    }
    pop = json["pop"] is int ? (json['pop'] as int).toDouble() : json['pop'];
    rain = json['rain'] != null ? Rain.fromJson(json['rain']) : null;
  }

  static List<HourlyForecast> listFromJson(List<dynamic> list) =>
      List<HourlyForecast>.from(list.map((x) => HourlyForecast.fromJson(x)));
}
