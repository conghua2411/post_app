import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PostImage extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final double borderRadius;
  final Widget child;

  PostImage(
      {@required this.url,
      this.width,
      this.height,
      this.borderRadius = 0,
      this.child});

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
            child: child,
          );
        },
        imageUrl: url,
        placeholder: (context, url) {
          return Container(
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    color: Color.fromRGBO(0, 0, 0, 0.2),
                    child: Center(
                      child: Icon(
                        Icons.image,
                        size: 56,
                      ),
                    ),
                  ),
                ),
                child,
              ],
            ),
          );
        },
        errorWidget: (context, url, error) {
          print('Url: $url - error: $error');
          return Container(
            child: Center(
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      color: Color.fromRGBO(0, 0, 0, 0.2),
                      child: Center(
                        child: Icon(
                          Icons.error,
                          size: 56,
                        ),
                      ),
                    ),
                  ),
                  child,
                ],
              ),
            ),
          );
        },
        fit: BoxFit.cover,
      ),
    );
  }
}
