import 'dart:convert';

import 'package:flutter/foundation.dart';

class GeoModel {
  double lat, lng;

  GeoModel({
    @required this.lat,
    @required this.lng,
  });

  GeoModel.fromJson(Map<String, dynamic> jsonData) {
    lat = double.parse(jsonData['lat']);
    lng = double.parse(jsonData['lng']);
  }

  Map<String, dynamic> toMap() {
    return {
      'lat': lat.toString(),
      'lng': lng.toString(),
    };
  }

  String toJsonString() => json.encode(toMap());
}
