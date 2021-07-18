import 'package:cafe_review/constant/colors.dart';
import 'package:cafe_review/constant/google_places_api.dart';
import 'package:cafe_review/core/widgets/rounded_corner_image.dart';
import 'package:cafe_review/features/cafe_detail/data/data.dart';
import 'package:flutter/material.dart';

class CafeListCard extends StatelessWidget {
  final CafeDetail detail;
  final double distance;
  final bool completed;
  final GestureTapCallback? onTap;

  const CafeListCard({
    Key? key,
    required this.detail,
    required this.distance,
    this.completed = false,
    this.onTap,
  }) : super(key: key);

  String _getPhotoUrl(String reference,
      {int maxWidth = 1080, int maxHeight = 600, required String key}) {
    return '$PHOTO?key=$key&photoreference=$reference&maxwidth=$maxWidth&maxheight=$maxHeight';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: AppColors.primary.withOpacity(0.34),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              detail.photos != null
                  ? RoundedCornerImage(
                      imageUrl: _getPhotoUrl(detail.photos![0].reference,
                          key: getApiKey()),
                    )
                  : DefaultRoundedCornerImage(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      detail.name,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor),
                    ),
                    Text(
                      detail.vicinity ?? 'Near by place.',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Distance: ',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text('${distance.toStringAsFixed(2)} m'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Open now: ',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    '${detail.openingHours == null ? 'Unknown' : detail.openingHours!.openNow ?? false ? 'Opened' : 'Closed'}',
                  ),
                ],
              ),
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
