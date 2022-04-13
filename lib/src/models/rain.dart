class Rain {
  double? d1h;

  Rain({this.d1h});

  Rain.fromJson(Map<String, dynamic> json) {
    d1h = json["1h"] is int ? (json['1h'] as int).toDouble() : json['1h'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['1h'] = this.d1h;
    return data;
  }
}
