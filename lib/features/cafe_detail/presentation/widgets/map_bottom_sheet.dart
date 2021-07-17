import 'dart:async';

import 'package:cafe_review/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapBottomSheet extends StatelessWidget {
  final String placeId;
  final double lat;
  final double lng;

  MapBottomSheet(
      {Key? key, required this.placeId, required this.lat, required this.lng})
      : super(key: key);

  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final CameraPosition _cameraPosition = CameraPosition(
      target: LatLng(lat, lng),
      zoom: 16,
    );
    final _cafeMarker = {
      Marker(
        markerId: MarkerId(placeId),
        position: LatLng(lat, lng),
      ),
    };
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(10.0),
          topRight: const Radius.circular(10.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppBar(
            elevation: 0.0,
            backgroundColor: AppColors.background,
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Text(
              'Cafe Map',
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(color: AppColors.primary),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close_outlined,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _cameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              myLocationEnabled: true,
              markers: _cafeMarker,
            ),
          ),
        ],
      ),
    );
  }
}
