import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ionicons/ionicons.dart';

class TripOnMap extends StatelessWidget {
  double Latitude;
  double Longitude;
  TripOnMap({super.key, required this.Latitude, required this.Longitude});

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  CameraPosition get tripPosition => CameraPosition(
        target: LatLng(Latitude, Longitude),
        zoom: 15.4746,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [

        GoogleMap(
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
        Positioned(
          top: 25, // Adjust this value for desired position
          left: 0, // Adjust this value for desired position
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            iconSize: 30,
            icon: const Icon(Ionicons.chevron_back),
          ),
        ),
      ]),
    );
  }
}
