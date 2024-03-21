import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPreferences? localStorage;
  static Future init() async {
    localStorage = await SharedPreferences.getInstance();
  }
}
