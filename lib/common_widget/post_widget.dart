import 'package:flutter/material.dart';
import 'package:post_app/common_widget/post_image.dart';
import 'package:post_app/common_widget/user_image.dart';
import 'package:post_app/model/post/post_model.dart';
import 'package:post_app/ui/post_detail/post_detail_page.dart';

class PostWidget extends StatefulWidget {
  final PostModel post;

  PostWidget({
    @required this.post,
  });

  @override
  State createState() => PostState();
}

class PostState extends State<PostWidget> {
  _gotoPostDetail(PostModel post) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PostDetailPage(
          post: widget.post,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          _gotoPostDetail(widget.post);
        },
        child: PostImage(
          url: 'https://picsum.photos/id/${widget.post.id * 10}/300/300',
          borderRadius: 8,
          child: Column(
            children: <Widget>[
              _buildHeader(widget.post),
              _buildTextHeader(widget.post.title),
              _buildBody(widget.post.body),
            ],
          ),
        ),
      ),
    );
  }

  _buildHeader(PostModel post) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Container(
        width: double.infinity,
        child: Row(
          children: <Widget>[
            UserImage(
              url:
                  'https://picsum.photos/id/${widget.post.userId * 111}/300/300',
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              post.id.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildTextHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  _buildBody(String body) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        body,
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );
  }
}
