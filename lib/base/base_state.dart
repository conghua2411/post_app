import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:post_app/service/language/language_service.dart';
import 'package:provider/provider.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  StreamSubscription _subMultiLanguage;

  @override
  void initState() {
    super.initState();

    _subMultiLanguage = Provider.of<LanguageService>(context, listen: false)
        .bsLangOut
        .listen((lang) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _subMultiLanguage.cancel();
    super.dispose();
  }
}
