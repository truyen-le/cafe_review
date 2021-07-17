import 'package:cafe_review/constant/colors.dart';
import 'package:cafe_review/constant/google_places_api.dart';
import 'package:cafe_review/core/widgets/rounded_corner_image.dart';
import 'package:cafe_review/features/cafe_detail/cafe_detail.dart';
import 'package:flutter/material.dart';

class CafeDetailCard extends StatelessWidget {
  final CafeDetail detail;
  const CafeDetailCard({Key? key, required this.detail}) : super(key: key);

  String _getPhotoUrl(String reference,
      {int maxWidth = 1080, int maxHeight = 600, String key = API_KEY}) {
    return '$PHOTO?key=$key&photoreference=$reference&maxwidth=$maxWidth&maxheight=$maxHeight';
  }

  Widget _buildImagesCarousel(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      height: MediaQuery.of(context).size.width * 9 / 16,
      child: PageView(
        scrollDirection: Axis.horizontal,
        controller: PageController(initialPage: 0),
        children: detail.photos!
            .map<Widget>(
              (photo) => Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: RoundedCornerImage(
                  imageUrl: _getPhotoUrl(photo.reference),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildDefaultImage(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: MediaQuery.of(context).size.width * 9 / 16,
      child: DefaultRoundedCornerImage(),
    );
  }

  Widget _buildDetailBody(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(
              detail.name,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: AppColors.primary,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'Address: ',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text('${detail.address ?? 'Near by'}'),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'Phone: ',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text('${detail.phoneNumber ?? 'Unknown'}'),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'Rating: ',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text('${detail.rating ?? 0.0}'),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'Open now: ',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    '${detail.openingHours == null ? 'Unknown' : detail.openingHours!.openNow ?? false ? 'Opened' : 'Closed'}',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottom(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                enableDrag: false,
                builder: (_) => MapBottomSheet(
                  placeId: detail.placeId,
                  lat: detail.geometry.location.latitude,
                  lng: detail.geometry.location.longitude,
                ),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.4,
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.map,
                    color: AppColors.background,
                  ),
                  Text(' Map'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        width: double.infinity,
        child: Column(
          children: [
            detail.photos != null
                ? _buildImagesCarousel(context)
                : _buildDefaultImage(context),
            _buildDetailBody(context),
            Divider(),
            _buildBottom(context),
          ],
        ),
      ),
    );
  }
}
