import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<void> saveList(String key, List<Map<String, dynamic>> list) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonEncode(list));
  }

  static Future<List<Map<String, dynamic>>> getList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(key);
    if (data != null) {
      return List<Map<String, dynamic>>.from(jsonDecode(data));
    } else {
      return [];
    }
  }
}
