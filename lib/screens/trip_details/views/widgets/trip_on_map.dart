import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:p/main.dart';
import 'package:rive/rive.dart';

class TripOnMap extends StatelessWidget {
  double Latitude;
  double Longitude;
  double width;
  double hight;
  TripOnMap(
      {super.key,
      required this.Latitude,
      required this.Longitude,
      required this.width,
      required this.hight});

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  CameraPosition get tripPosition => CameraPosition(
        target: LatLng(Latitude, Longitude),
        zoom: 15.4746,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: hight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            GoogleMap(
              liteModeEnabled: true,
              mapType: MapType.normal,
              zoomControlsEnabled: false,
              initialCameraPosition: tripPosition,
              cameraTargetBounds: CameraTargetBounds(LatLngBounds(
                northeast: const LatLng(31.916667, 35.000000),
                southwest: const LatLng(22.000000, 25.000000),
              )),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),

          ],
        ),
      ),
    );
  }
}
