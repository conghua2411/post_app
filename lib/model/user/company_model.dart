import 'dart:convert';

import 'package:flutter/foundation.dart';

class CompanyModel {
  String name;
  String catchPhrase;
  String bs;

  CompanyModel({
    @required this.name,
    @required this.catchPhrase,
    @required this.bs,
  });

  CompanyModel.decodeJson(Map<String, dynamic> jsonData) {
    name = jsonData['name'];
    catchPhrase = jsonData['catchPhrase'];
    bs = jsonData['bs'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'catchPhrase': catchPhrase,
      'bs': bs,
    };
  }

  String toJsonString() => json.encode(toMap());
}
