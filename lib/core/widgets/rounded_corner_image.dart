import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RoundedCornerImage extends StatelessWidget {
  final double aspectRatio;
  final String imageUrl;
  final BoxFit fit;

  const RoundedCornerImage({
    Key? key,
    this.aspectRatio = 16 / 9,
    this.imageUrl = '',
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          width: double.infinity,
          imageUrl: imageUrl,
          placeholder: (context, url) => Container(
            width: double.infinity,
            color: Theme.of(context).accentColor,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
              ),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            width: double.infinity,
            color: Theme.of(context).accentColor,
            child: Center(
              child: Icon(
                Icons.error,
                color: Theme.of(context).errorColor,
              ),
            ),
          ),
          fit: fit,
        ),
      ),
    );
  }
}
