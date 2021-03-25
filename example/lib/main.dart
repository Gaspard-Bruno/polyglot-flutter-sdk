import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:provider/provider.dart';
import 'package:polyglot_flutter_sdk/polyglot_flutter_sdk.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PolyglotLanguage appLanguage = PolyglotLanguage.instance;
  await appLanguage.init(
      projectUrl:
          'https://d8wlqn7pvlrac.cloudfront.net/c81e728d9d4c2f636f067f89cc14862c/all.json',
      defaultLocale: 'en_US');
  runApp(MyApp(
    appLanguage: appLanguage,
  ));
}

class MyApp extends StatelessWidget {
  final PolyglotLanguage appLanguage;

  MyApp({required this.appLanguage});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PolyglotLanguage>(
      create: (_) => appLanguage,
      child: Consumer<PolyglotLanguage>(builder: (context, model, child) {
        return MaterialApp(
          locale: model.appLocal,
          title: "POLYGLOT",
          localizationsDelegates: [
            const PolyLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            FallbackLocalizationDelegate(),
          ],
          supportedLocales: model.suportedLocales,
          home: MyHomePage(title: 'Flutter Demo Home Page'),
        );
      }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? title;
  String? description;
  PolyglotModel? polyModel;

  _MyHomePageState();

  @override
  Widget build(BuildContext context) {
    //
    var appLanguage = Provider.of<PolyglotLanguage>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(PolyLocalizations.of(context)
                ?.translate('landing.translationdemo.description') ??
            ""),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                PolyLocalizations.of(context)?.translate('landing.wemake') ??
                    "",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
              Text(
                PolyLocalizations.of(context)
                        ?.translate('landing.translationdemo.description') ??
                    "",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.green),
              ),
              Text(
                PolyLocalizations.of(context)?.translate('landing.backedby') ??
                    "",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18, color: Colors.blue[400]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  PolyLocalizations.of(context)
                          ?.translate('landing.copyright') ??
                      "",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.teal),
                ),
              ),
              Center(
                child: Wrap(
                  children: [
                    for (var lang in appLanguage.localizedStrings!.langs!.keys)
                      Container(
                        margin: const EdgeInsets.all(12),
                        child: TextButton(
                          child: Text('Polyglot $lang'),
                          onPressed: () {
                            print(lang);
                            appLanguage.changeLanguageFromString(lang);
                          },
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
