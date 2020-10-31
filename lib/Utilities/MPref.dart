import 'package:shared_preferences/shared_preferences.dart';

class MPref {
  static MPref _storageUtil;
  static SharedPreferences _preferences;

  static Future<MPref> getInstance() async {
    if (_storageUtil == null) {
      // keep local instance till it is fully initialized.
      var secureStorage = MPref._();
      await secureStorage._init();
      _storageUtil = secureStorage;
    }
    return _storageUtil;
  }

  MPref._();
  Future _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // get string
  static String getString(String key, {String defValue = ''}) {
    if (_preferences == null) return defValue;
    return _preferences.getString(key) ?? defValue;
  }

  // put string
  static Future<bool> setString(String key, String value) {
    if (_preferences == null) return null;
    return _preferences.setString(key, value);
  }

/// Returns true if persistent storage the contains the given [key].
  static bool containsKey(String key) {
    return _preferences.containsKey(key);
  }

 

  static Future<bool> remove(String key) async {
    return _preferences?.remove(key) ?? Future.value(false);
  }

  static Future<bool> clear() async {
    return _preferences?.clear() ?? Future.value(false);
  }
}
