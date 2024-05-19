import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:homepage/l10n/l10n.dart';

import 'package:homepage/theme/theme_constants.dart';
import 'package:homepage/theme/theme_manager.dart';
import 'package:homepage/l10n/lang_manager.dart';

import 'package:homepage/pages/handler.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PageHandler(),
      child: MyApp(),
    ),
  );
}

/*
TODO general features:
  Loading Bar
  Backend integration (+badge)
*/

ThemeManager _themeManager = ThemeManager();
LangManager _langManager = LangManager();

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    _langManager.removeListener(themeListener);

    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    _langManager.addListener(themeListener);
    super.initState();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
      home: MyHomeScreen(),
      supportedLocales: L10n.all,
      locale: _langManager.language,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    PageHandler handler = context.read<PageHandler>();

    List<Widget> actions = handler.buildActions();

    actions.add(DropdownButton<String>(
      value: _langManager.language.languageCode,
      items: L10n.all
          .map((e) => DropdownMenuItem(
              child: Text(e.languageCode), value: e.languageCode))
          .toList(),
      onChanged: (String? newValue) {
        _langManager.toggleTheme(newValue!);
      },
    ));

    actions.add(
      Container(
        margin: EdgeInsets.fromLTRB(5, 2, 5, 2),
        width: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(
            _langManager.language.languageCode,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );

    actions.add(TextButton(
      onPressed: () => {
        _langManager.toggleTheme(
            _langManager.language.languageCode == "en" ? "de" : "en")
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 243, 33, 243)),
      ),
      child: Text(_langManager.language.languageCode),
    ));

    actions.add(
      Switch(
          value: _themeManager.themeMode == ThemeMode.dark,
          onChanged: (newValue) {
            _themeManager.toggleTheme(newValue);
          }),
    );

    return Consumer<PageHandler>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text("Theme App"),
          actions: actions,
        ),
        body: handler.buildBody(),
      ),
    );
  }
}
