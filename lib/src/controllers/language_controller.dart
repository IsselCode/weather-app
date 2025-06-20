import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LanguageController extends ChangeNotifier {

  Locale _locale = Locale("en");
  Locale get locale => _locale;

  LanguageController() {
    Intl.defaultLocale = "en";
  }

  void changeLocale(String languageCode) {
    _locale = Locale(languageCode);
    Intl.defaultLocale = languageCode;
    notifyListeners();
  }

}