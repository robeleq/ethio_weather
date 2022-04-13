class Config {
  static const String PRIVACY_URL = "";
  static const String APP_PLAY_STORE_URL = "";
  static const String APP_NETLIFY_URL = "";

  static const String API_BASE_URL = "api.openweathermap.org";
  static final ONECALL_API_ENDPOINT_URL = Uri.https(API_BASE_URL, 'data/2.5/onecall', {
    'lat': '8',
    'lon': '38.76',
    'appid': 'fc39d687bb2ddba85f930d72cc93f5ea',
    'units': 'metric',
    'lang': 'en',
  });
}
