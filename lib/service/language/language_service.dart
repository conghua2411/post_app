import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:post_app/service/shared_preference/shared_preference_service.dart';
import 'package:rxdart/rxdart.dart';

import 'language_resource/en.dart';
import 'language_resource/kr.dart';

class LanguageService {
  String currentLang = 'en';

  BehaviorSubject<String> _bsLangIn;
  BehaviorSubject<String> bsLangOut;

  var _language = {'en': enLanguage, 'kr': krLanguage};

  StreamSubscription<String> subscriptionLang;

  final SharedPreferenceService prefService;

  LanguageService({
    @required this.prefService,
  }) {

    currentLang = prefService.getCurrentLanguage() ?? 'en';
    print('LanguageService: constructor - current language: $currentLang');

    _bsLangIn = BehaviorSubject();
    bsLangOut = BehaviorSubject();

    subscriptionLang = _bsLangIn.listen((lang) {
      currentLang = lang;
      bsLangOut.add(currentLang);
    });
  }

  dispose() {
    print('LanguageService: dispose');
    subscriptionLang.cancel();
    _bsLangIn.close();
    bsLangOut.close();
  }

  _getLang(String key, {List value}) {
    if (value != null) {
      return _language[currentLang][key](value) ??
          (throw Exception('Not found key: $key in $currentLang'));
    } else {
      return _language[currentLang][key] ??
          (throw Exception('Not found key: $key in $currentLang'));
    }
  }

  getStringKey(String key, {List value}) {
    try {
      return _getLang(key, value: value);
    } catch (e) {
      print('MultipleLanguageError: $e');
      return 'null';
    }
  }

  /// Change language
  changeLanguage(String lang) => _bsLangIn.add(lang);
}
