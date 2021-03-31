class PolyglotModel {
  Map<String, Map<String, String>>? langs;

  PolyglotModel({this.langs});

  List<String> get languages {
    return langs?.keys.toList() ?? [];
  }

  PolyglotModel.fromJson(Map<String, dynamic> data) {
    langs = data.map((key, value) => MapEntry<String, Map<String, String>>(
        _toLanguageTag(key), Map<String, String>.from(value)));
  }
}

extension on PolyglotModel {
  String _toLanguageTag(String key) {
    final regx = RegExp(r'([a-z]*)-([a-z]*)');

    return key.splitMapJoin(regx,
        onMatch: (m) => '${m.group(1)}_${m.group(2)?.toUpperCase() ?? ""}',
        onNonMatch: (n) => '${n.substring(0)}');
  }
}
