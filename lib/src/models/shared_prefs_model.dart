import 'package:shared_preferences/shared_preferences.dart';

const latKey = "latitude";
const lngKey = "longitude";
const themeKey = "theme_key";
const languageCodeKey = "language_code_key";

class SharedPrefsModel {

  SharedPreferences shared;

  SharedPrefsModel({
    required this.shared
  });

  Future<void> saveLocation(double lat, double lng) async {
    await shared.setDouble(latKey, lat);
    await shared.setDouble(lngKey, lng);
  }

  (double?, double?) getLocation() {

    final lat = shared.getDouble(latKey);
    final lng = shared.getDouble(lngKey);

    return (lat, lng);

  }

  Future<void> saveTheme(bool isDark) async {
    await shared.setBool(themeKey, isDark);
  }

  bool getTheme() {
    return shared.getBool(themeKey) ?? false;
  }

  Future<void> saveLanguage(String code) async {
    await shared.setString(languageCodeKey, code);
  }

  String? getLanguage() {
    return shared.getString(languageCodeKey);
  }

}