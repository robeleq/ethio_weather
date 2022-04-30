class SupportedLocale {
  final String _language;
  final String _languageCode;

  const SupportedLocale(this._languageCode, this._language);

  String get language => _language;
  String get languageCode => _languageCode;
}
