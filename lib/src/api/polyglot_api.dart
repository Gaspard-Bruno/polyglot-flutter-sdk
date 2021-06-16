import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:polyglot_flutter_sdk/src/api/base_polyglot_api.dart';
import 'package:polyglot_flutter_sdk/src/model/polyglot_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PolyglotApi extends BasePolyglotApi {
  const PolyglotApi({required projectUrl}) : super(projectUrl: projectUrl);

  @override
  Future<PolyglotModel?> getPolyglotLanguages() async {
    try {
      final url = Uri.parse(projectUrl);
      final response = await http.get(url,
          headers: {"Content-Type": "application/json; charset=UTF-8"});
      if (response.statusCode != 200)
        throw HttpException('${response.statusCode}');
      final body = utf8.decode(response.bodyBytes);
      final prefs = await SharedPreferences.getInstance();
      var cachedString = prefs.getString('cached_languages');
      if (cachedString == null || cachedString != body) {
        prefs.setString('cached_languages', body);
        cachedString = body;
      }
      return PolyglotModel.fromJson(jsonDecode(cachedString));
    } on SocketException {
      print('No Internet connection');
    } on HttpException {
      print("Couldn't find the Languages");
    } on FormatException {
      print("Bad response format");
    }
  }
}
