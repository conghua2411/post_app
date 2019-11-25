import 'package:flutter/foundation.dart';

class PostModel {
  int userId;
  int id;
  String title;
  String body;

  PostModel({
    @required this.userId,
    @required this.id,
    @required this.title,
    @required this.body,
  });

  PostModel.fromJson(Map<String, dynamic> jsonData) {
    userId = jsonData['userId'];
    id = jsonData['id'];
    title = jsonData['title'];
    body = jsonData['body'];
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }
}
