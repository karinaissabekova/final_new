import 'package:shared_preferences/shared_preferences.dart';

class AppSettings {
  static late SharedPreferences prefs;

  static Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static String get lang => prefs.getString("lang") ?? "en";
  static set lang(String value) => prefs.setString("lang", value);

  static bool get isDark => prefs.getBool("theme") ?? false;
  static set isDark(bool value) => prefs.setBool("theme", value);
}