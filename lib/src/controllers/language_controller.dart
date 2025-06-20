import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/src/models/shared_prefs_model.dart';

class LanguageController extends ChangeNotifier {

  SharedPrefsModel sharedPrefsModel;

  Locale _locale = Locale("en");
  Locale get locale => _locale;

  LanguageController({
    required this.sharedPrefsModel
  }) {
    String? langStored = sharedPrefsModel.getLanguage();
    Intl.defaultLocale = langStored ?? "en";
    _locale = Locale(langStored ?? "en");
    notifyListeners();
  }

  Future<void> changeLocale(String languageCode) async {
    _locale = Locale(languageCode);
    Intl.defaultLocale = languageCode;
    await sharedPrefsModel.saveLanguage(languageCode);
    notifyListeners();
  }

}