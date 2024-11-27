import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {

  static final SharedPrefs _instance = SharedPrefs._internal();

  factory SharedPrefs() {
    return _instance;
  }

  SharedPrefs._internal();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  String? getString(String key) {
    return _prefs?.getString(key);
  }

  // Future<void> remove(String key) async {
  //   await _prefs?.remove(key);
  // }
  // Future<void> clear() async {
  //   await _prefs?.clear();
  // }
}
