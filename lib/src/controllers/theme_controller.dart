import 'package:flutter/material.dart';

import '../models/shared_prefs_model.dart';

class ThemeController extends ChangeNotifier {

  SharedPrefsModel shared;

  ThemeController({
    required this.shared
  });

  bool getTheme() {
    return shared.getTheme();
  }

  Future<void> saveTheme(bool isDark) async {
    await shared.saveTheme(isDark);
    notifyListeners();
  }

}