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
        return Locale(e);
      }).toList() ??
      [];

  PolyglotModel? get localizedStrings => _localizedStrings;

  Future<bool> init({required String apiKey}) async {
    _polyglotApi = PolyglotApi(apiKey: apiKey);
    _localizedStrings = await _polyglotApi?.getPolyglotLanguages();
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      _appLocale = Locale('us');
      return true;
    }
    _appLocale = Locale(prefs.getString('language_code') ?? "en");
    return true;
  }

  void changeLanguage(Locale locale) async {
    if (suportedLocales.contains(locale)) {
      _appLocale = locale;
      notifyListeners();
    }
  }
}
