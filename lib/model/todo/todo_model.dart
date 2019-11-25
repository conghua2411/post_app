import 'package:flutter/foundation.dart';

class TodoModel {
  int userId;
  int id;
  String title;
  bool completed;

  TodoModel({
    @required this.userId,
    @required this.id,
    @required this.title,
    @required this.completed,
  });
}
