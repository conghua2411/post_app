import 'package:flutter/foundation.dart';

class AlbumModel {
  int userId;
  int id;
  String title;

  AlbumModel({
    @required this.userId,
    @required this.id,
    @required this.title,
  });
}