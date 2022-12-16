import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

// 存储单利
final Future<SharedPreferences> _preferences = SharedPreferences.getInstance();

class CacheTool {
  static saveObject(String key, Object? value) async {
    if (value != null) {
      SharedPreferences pre = await _preferences;
      String obj = json.encode(value);
      pre.setString(key, obj);
    }
  }

  static getObject(String key) async {
    SharedPreferences pre = await _preferences;
    String? value = pre.getString(key);
    if (value != null) {
      return json.decode(value);
    }
  }

  static removeObject(String key) async {
    SharedPreferences pre = await _preferences;
    pre.remove(key);
  }

  static clear(String key) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
