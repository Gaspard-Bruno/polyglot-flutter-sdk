import 'package:flutter/widgets.dart';
import 'package:polyglot_flutter_sdk/src/polyglot_language.dart';
import 'package:provider/provider.dart';

class PolyglotProvider extends StatelessWidget {
  final PolyglotLanguage appLanguage;
  final Widget child;

  PolyglotProvider({Key? key, required this.appLanguage, required this.child});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PolyglotLanguage>(
      create: (_) => appLanguage,
      child: Consumer<PolyglotLanguage>(builder: (context, model, child) {
        return child ?? this.child;
      }),
    );
  }
}
