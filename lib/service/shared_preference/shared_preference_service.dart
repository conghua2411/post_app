import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  SharedPreferences pref;

  SharedPreferenceService({
    @required this.pref,
  });

  Future<bool> setCurrentLanguage(String lang) => pref.setString('current_language', lang);
  String getCurrentLanguage() => pref.getString('current_language');
}
