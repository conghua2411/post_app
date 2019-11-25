import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:post_app/model/user/geo_model.dart';

class AddressModel {
  String street;
  String suite;
  String city;
  String zipCode;
  GeoModel geo;

  AddressModel({
    @required this.street,
    @required this.suite,
    @required this.city,
    @required this.zipCode,
    @required this.geo,
  });

  AddressModel.fromJson(Map<String, dynamic> jsonData) {
    street = jsonData['street'];
    suite = jsonData['suite'];
    city = jsonData['city'];
    zipCode = jsonData['zipCode'];
    geo = GeoModel.fromJson(jsonData['geo'] is String
        ? json.decode(jsonData['geo'])
        : jsonData['geo']);
  }

  Map<String, dynamic> toMap() {
    return {
      'street': street,
      'suite': suite,
      'city': city,
      'zipCode': zipCode,
      'geo': geo.toJsonString(),
    };
  }

  String toJsonString() => json.encode(toMap());
}
