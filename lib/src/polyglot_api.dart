import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:polyglot_flutter_sdk/src/constants.dart';

import 'package:polyglot_flutter_sdk/src/polyglot_model.dart';

class PolyglotApi {
  final String apiKey;

  const PolyglotApi({required this.apiKey});

  Future<PolyglotModel> getPolyglotLanguages() async {
    //TODO: Use api key on server url
    final url = Uri.parse(Constants.serverUlr);
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final jsonString = json.decode(utf8.decode(response.bodyBytes));
    return PolyglotModel.fromJson(jsonString);
  }
}
