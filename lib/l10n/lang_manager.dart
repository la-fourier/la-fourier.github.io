import 'package:flutter/material.dart';
import 'package:homepage/l10n/l10n.dart';

class LangManager with ChangeNotifier {
  Locale _language = Locale('en');

  get language => _language;

  toggleTheme(String lang) {
    if (L10n.all.contains(Locale(lang))) {
      _language = Locale(lang);
    } else {
      _language = Locale('en');
    }
    notifyListeners();
  }
}
