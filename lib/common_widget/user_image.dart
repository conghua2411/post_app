import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final double borderRadius;

  UserImage({
    @required this.url,
    this.width = 48,
    this.height = 48,
    this.borderRadius = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: CachedNetworkImage(
        imageBuilder: (context, imageProvider) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        imageUrl: url,
        placeholder: (context, url) {
          return Center(
            child: Icon(Icons.person),
          );
        },
        errorWidget: (context, url, error) {
          print('Url: $url - error: $error');
          return Center(
            child: Icon(Icons.error),
          );
        },
        fit: BoxFit.cover,
      ),
    );
  }
}
