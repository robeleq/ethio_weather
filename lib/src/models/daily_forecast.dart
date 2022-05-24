import 'feels_like.dart';
import 'temp.dart';
import 'weather.dart';

class DailyForecast {
  int? dt;
  int? sunrise;
  int? sunset;
  int? moonrise;
  int? moonset;
  double? moonPhase;
  Temp? temp;
  FeelsLike? feelsLike;
  int? pressure;
  int? humidity;
  double? dewPoint;
  double? windSpeed;
  int? windDeg;
  double? windGust;
  List<Weather>? weather;
  int? clouds;
  double? pop;
  double? rain;
  double? uvi;

  DailyForecast(
      {this.dt,
      this.sunrise,
      this.sunset,
      this.moonrise,
      this.moonset,
      this.moonPhase,
      this.temp,
      this.feelsLike,
      this.pressure,
      this.humidity,
      this.dewPoint,
      this.windSpeed,
      this.windDeg,
      this.windGust,
      this.weather,
      this.clouds,
      this.pop,
      this.rain,
      this.uvi});

  DailyForecast.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    moonrise = json['moonrise'];
    moonset = json['moonset'];
    moonPhase = json["moon_phase"] is int ? (json['moon_phase'] as int).toDouble() : json['moon_phase'];
    temp = json['temp'] != null ? new Temp.fromJson(json['temp']) : null;
    feelsLike = json['feels_like'] != null ? new FeelsLike.fromJson(json['feels_like']) : null;
    pressure = json['pressure'];
    humidity = json['humidity'];
    dewPoint = json["dew_point"] is int ? (json['dew_point'] as int).toDouble() : json['dew_point'];
    windSpeed = json["wind_speed"] is int ? (json['wind_speed'] as int).toDouble() : json['wind_speed'];
    windDeg = json['wind_deg'];
    windGust = json["wind_gust"] is int ? (json['wind_gust'] as int).toDouble() : json['wind_gust'];
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather!.add(Weather.fromJson(v));
      });
    }
    clouds = json['clouds'];
    pop = json["pop"] is int ? (json['pop'] as int).toDouble() : json['pop'];
    rain = json["rain"] is int ? (json['rain'] as int).toDouble() : json['rain'];
    uvi = json["uvi"] is int ? (json['uvi'] as int).toDouble() : json['uvi'];
  }

  static List<DailyForecast> listFromJson(List<dynamic> list) =>
      List<DailyForecast>.from(list.map((x) => DailyForecast.fromJson(x)));
}
