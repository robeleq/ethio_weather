import 'weather.dart';

class CurrentWeather {
  int? dt;
  int? sunrise;
  int? sunset;
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

  CurrentWeather(
      {this.dt,
      this.sunrise,
      this.sunset,
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
      this.weather});

  CurrentWeather.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['dt'] = this.dt;
    data['sunrise'] = this.sunrise;
    data['sunset'] = this.sunset;
    data['temp'] = this.temp;
    data['feels_like'] = this.feelsLike;
    data['pressure'] = this.pressure;
    data['humidity'] = this.humidity;
    data['dew_point'] = this.dewPoint;
    data['uvi'] = this.uvi;
    data['clouds'] = this.clouds;
    data['visibility'] = this.visibility;
    data['wind_speed'] = this.windSpeed;
    data['wind_deg'] = this.windDeg;
    data['wind_gust'] = this.windGust;
    if (this.weather != null) {
      data['weather'] = this.weather!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
