import 'package:polyglot_flutter_sdk/src/model/polyglot_model.dart';

abstract class BasePolyglotApi {
  final String projectUrl;

  const BasePolyglotApi({required this.projectUrl});

  Future<PolyglotModel?> getPolyglotLanguages();
}
