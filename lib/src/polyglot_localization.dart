import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

import 'polyglot_language.dart';

class PolyLocalizations {
  PolyLocalizations(this.locale);

  final Locale locale;

  static PolyLocalizations? of(BuildContext context) {
    return Localizations.of<PolyLocalizations>(context, PolyLocalizations);
  }

  static Map<String, Map<String, String>>? _localizedValues =
      PolyglotLanguage.instance.localizedStrings?.langs;

  String translate(String key) {
    return _localizedValues?[locale.languageCode]?[key] ?? "";
  }
}

class PolyLocalizationsDelegate
    extends LocalizationsDelegate<PolyLocalizations> {
  const PolyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      PolyglotLanguage.instance.localizedStrings!.langs!.keys
          .contains(locale.languageCode);

  @override
  Future<PolyLocalizations> load(Locale locale) {
    return SynchronousFuture<PolyLocalizations>(PolyLocalizations(locale));
  }

  @override
  bool shouldReload(PolyLocalizationsDelegate old) => false;
}

class FallbackLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  @override
  bool isSupported(Locale locale) => true;
  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      DefaultMaterialLocalizations();
  @override
  bool shouldReload(_) => false;
}
