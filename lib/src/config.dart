class Config {
  const Config._();

  static const String privacyUrl = "";
  static const String playStoreUrl = "";
  static const String APP_NETLIFY_URL = "";

  static const String apiBaseUrl = "api.openweathermap.org";
  static final apiOneCallUrl = Uri.https(apiBaseUrl, 'data/2.5/onecall', {
    'lat': '8',
    'lon': '38.76',
    'appid': 'fc39d687bb2ddba85f930d72cc93f5ea',
    'units': 'metric',
    'lang': 'en',
  });
}
