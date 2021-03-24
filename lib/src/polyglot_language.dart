import 'package:flutter/material.dart';
import 'package:polyglot_flutter_sdk/src/polyglot_api.dart';
import 'package:polyglot_flutter_sdk/src/polyglot_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PolyglotLanguage extends ChangeNotifier {
  PolyglotApi? _polyglotApi;
  Locale _appLocale = Locale('en');

  late PolyglotModel? _localizedStrings;

  PolyglotLanguage._internal();

  static final PolyglotLanguage _instance = PolyglotLanguage._internal();

  static PolyglotLanguage get instance => _instance;

  Locale get appLocal => _appLocale;

  List<Locale> get suportedLocales =>
      _localizedStrings?.langs?.keys.map((e) {
        return _getLocale(e);
      }).toList() ??
      [];

  PolyglotModel? get localizedStrings => _localizedStrings;

  Future init({required String apiKey, required String defaultLocale}) async {
    _polyglotApi = PolyglotApi(apiKey: apiKey);
    _localizedStrings = await _polyglotApi?.getPolyglotLanguages();
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      _appLocale = _getLocale(defaultLocale);
    } else {
      _appLocale = Locale(prefs.getString('language_code') ?? "en");
    }
  }

  void changeLanguage(Locale locale) async {
    var prefs = await SharedPreferences.getInstance();
    if (suportedLocales.contains(locale)) {
      _appLocale = locale;
      prefs.setString('language_code', locale.toLanguageTag());
      notifyListeners();
    }
  }

  void changeLanguageFromString(String localeStr) async {
    var prefs = await SharedPreferences.getInstance();
    var locale = _getLocale(localeStr);
    if (suportedLocales.contains(locale)) {
      _appLocale = locale;
      prefs.setString('language_code', localeStr);
      notifyListeners();
    }
  }

  Locale _getLocale(String langCode) {
    var sufixs = langCode.split('-');
    switch (sufixs.length) {
      case 1:
        return Locale(sufixs[0]);
      case 2:
        return Locale(sufixs[0], sufixs[1]);
      default:
        return Locale(_localizedStrings?.langs?.keys.first ?? "en");
    }
  }
}
