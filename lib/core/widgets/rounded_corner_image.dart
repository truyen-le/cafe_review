import 'package:cached_network_image/cached_network_image.dart';
import 'package:cafe_review/constant/colors.dart';
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
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              border: Border.all(color: AppColors.primary),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
              ),
            ),
          ),
          errorWidget: (context, url, error) => Image.asset(
            'assets/images/image_placeholder.png',
            fit: BoxFit.cover,
          ),
          fit: fit,
        ),
      ),
    );
  }
}

class DefaultRoundedCornerImage extends StatelessWidget {
  final double aspectRatio;
  final BoxFit fit;

  const DefaultRoundedCornerImage({
    Key? key,
    this.aspectRatio = 16 / 9,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          'assets/images/image_placeholder.png',
          fit: fit,
        ),
      ),
    );
  }
}
