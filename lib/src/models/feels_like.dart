class FeelsLike {
  double? day;
  double? night;
  double? eve;
  double? morn;

  FeelsLike({this.day, this.night, this.eve, this.morn});

  FeelsLike.fromJson(Map<String, dynamic> json) {
    day = json["day"] is int ? (json['day'] as int).toDouble() : json['day'];
    night = json["night"] is int ? (json['night'] as int).toDouble() : json['night'];
    eve = json["eve"] is int ? (json['eve'] as int).toDouble() : json['eve'];
    morn = json["morn"] is int ? (json['morn'] as int).toDouble() : json['morn'];
  }
}
