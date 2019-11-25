import 'package:flutter/material.dart';
import 'package:post_app/model/post/post_model.dart';
import 'package:post_app/ui/post_detail/post_detail_page.dart';

getPostDetailRoute(PostModel postModel) {
  return MaterialPageRoute(
    builder: (_) => PostDetailPage(
      post: postModel,
    ),
  );
}
