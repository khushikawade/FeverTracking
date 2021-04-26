import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesTest {
  // set string value
  Future<String> setString(String key, String value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, value);
  }

  // get string value
  Future<String> getString(String key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.get(key) ?? '';
  }

  Future<int> setInteger(String key, int value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt(key, value);
  }

  // get string value
  Future<int> getInteger(String key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.get(key) ?? 0;
  }

  // set string value
  Future<bool> setBool(String key, bool value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(key, value);
  }

  // get string value
  Future<bool> getBool(String key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.get(key) ?? false;
  }

  void clear() async {
    SharedPreferences prefs = await _getSharedPreference();
    prefs.clear();
  }

  _getSharedPreference() async {
    return await SharedPreferences.getInstance();
  }
}
