import 'package:flutter/foundation.dart';

class PhotoModel {
  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  PhotoModel({
    @required this.albumId,
    @required this.id,
    @required this.title,
    @required this.url,
    @required this.thumbnailUrl,
  });
}
