import 'package:flutter/material.dart';
import 'package:post_app/base/base_state.dart';
import 'package:post_app/common_widget/post_image.dart';
import 'package:post_app/common_widget/user_image.dart';
import 'package:post_app/model/post/post_model.dart';
import 'package:post_app/ui/user_detail/user_detail_route.dart';

class PostDetailPage extends StatefulWidget {
  final PostModel post;

  PostDetailPage({
    @required this.post,
  });

  @override
  State createState() => PostDetailState();
}

class PostDetailState extends BaseState<PostDetailPage> {
  _gotoUserDetail(int userId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => getUserDetailRoute(widget.post.userId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.post.title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: InkWell(
                  onTap: () {
                    _gotoUserDetail(widget.post.userId);
                  },
                  child: UserImage(
                    url:
                        'https://picsum.photos/id/${widget.post.userId * 111}/300/300',
                    width: 48,
                    height: 48,
                    borderRadius: 24,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: PostImage(
                  url:
                      'https://picsum.photos/id/${widget.post.id * 10}/300/300',
                  height: 250,
                  borderRadius: 12,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  widget.post.body,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
