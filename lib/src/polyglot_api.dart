import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:polyglot_flutter_sdk/src/polyglot_model.dart';

class PolyglotApi {
  final String projectUrl;

  const PolyglotApi({required this.projectUrl});

  Future<PolyglotModel> getPolyglotLanguages() async {
    final url = Uri.parse(projectUrl);
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final jsonString = json.decode(utf8.decode(response.bodyBytes));
    return PolyglotModel.fromJson(jsonString);
  }
}
