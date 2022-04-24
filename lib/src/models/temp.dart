class Temp {
  double? day;
  double? min;
  double? max;
  double? night;
  double? eve;
  double? morn;

  Temp({this.day, this.min, this.max, this.night, this.eve, this.morn});

  Temp.fromJson(Map<String, dynamic> json) {
    day = json["day"] is int ? (json['day'] as int).toDouble() : json['day'];
    min = json["min"] is int ? (json['min'] as int).toDouble() : json['min'];
    max = json["max"] is int ? (json['max'] as int).toDouble() : json['max'];
    night = json["night"] is int ? (json['night'] as int).toDouble() : json['night'];
    eve = json["eve"] is int ? (json['eve'] as int).toDouble() : json['eve'];
    morn = json["morn"] is int ? (json['morn'] as int).toDouble() : json['morn'];
  }
}
