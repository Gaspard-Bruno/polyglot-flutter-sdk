class PolyglotModel {
  Map<String, Map<String, String>>? langs;

  PolyglotModel({this.langs});

  List<String> get languages {
    return langs?.keys.toList() ?? [];
  }

  PolyglotModel.fromJson(Map<String, dynamic> data) {
    langs = data.map((key, value) => MapEntry<String, Map<String, String>>(
        key, Map<String, String>.from(value)));
  }
}

class PolyLanguages {
  Map<String, String>? localizedStrings;

  PolyLanguages(key, {this.localizedStrings});

  PolyLanguages.fromJson(Map<String, dynamic> data) {
    localizedStrings = Map<String, String>.from(data);
  }

  String toString() => "${localizedStrings.toString()}";
}
