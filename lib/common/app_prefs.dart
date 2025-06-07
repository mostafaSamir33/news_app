import 'package:shared_preferences/shared_preferences.dart';

class AppPrefs{
  static late SharedPreferences prefs;

  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  //localization
  static Future<void> localizationSetBool(
      String key, bool value) async {
    await prefs.setBool(key, value);
  }

  static bool? localizationGetBool(String key) {
    return prefs.getBool(key);
  }
//theme
  static Future<void> themeSetBool(
      String key, bool value) async {
    await prefs.setBool(key, value);
  }

  static bool? themeGetBool(String key) {
    return prefs.getBool(key);
  }
}