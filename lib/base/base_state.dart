import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:post_app/service/language/language_service.dart';
import 'package:provider/provider.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  StreamSubscription _subMultiLanguage;

  A getComponent<A>() => Provider.of<A>(
        context,
        listen: false,
      );

  @override
  void initState() {
    super.initState();

    _subMultiLanguage = getComponent<LanguageService>()
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
