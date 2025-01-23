import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapBody extends StatefulWidget {
  MapBody({super.key});

  @override
  State<MapBody> createState() => _MapBodyState();
}

class _MapBodyState extends State<MapBody> {
  StreamSubscription<LocationData>? streamSubscription;

  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  CameraPosition? MyLocation;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  List<LatLng> points = [];
  int index = 0;
  static const CameraPosition _kLake = CameraPosition(
      bearing: 99.8334901395799,
      target: LatLng(29.9610721, 31.2605734),
      tilt: 59.440717697143555,
      zoom: 22.151926040649414);


  @override
  Widget build(BuildContext context) {
    canAccessLocation();
    return MyLocation == null
        ? Center(child: CircularProgressIndicator())
        :GoogleMap (
      mapType: MapType.normal,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      initialCameraPosition: MyLocation!,
      markers: markers,
      onTap: (argument) {
        markers.add(Marker(
            markerId: MarkerId("userId:${index++}"),
            position: argument));
        setState(() {});
      },
      polylines: polylines ,
      cameraTargetBounds: CameraTargetBounds(LatLngBounds(
        northeast: LatLng(31.916667, 35.000000),
        southwest: LatLng(22.000000, 25.000000),
      )),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    )

    ;
  }

  Location location = new Location();
  PermissionStatus _permissionGranted = PermissionStatus.denied;
  bool _serviceEnabled = false;
  LocationData? locationData;

  Future<bool> isPermissionGranted() async {
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
    }
    return _permissionGranted == PermissionStatus.granted;
  }

  Future<bool> isServiceEnabled() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
    }
    return _serviceEnabled;
  }

  canAccessLocation() async {
    bool permissionGranted = await isPermissionGranted();
    if (!permissionGranted) return;
    bool serviceEnable = await isServiceEnabled();
    if (!serviceEnable) return;
    locationData = await location.getLocation();
    location.changeSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
      interval: 1000 * 10,
    );
    streamSubscription = location.onLocationChanged.listen((event) {
      locationData = event;
      markers.add(Marker(
        markerId: MarkerId("myLocation"),
        position: LatLng(event.latitude ?? 0, event.longitude ?? 0),
      ));
      points.add(LatLng(event.latitude ?? 0, event.longitude ?? 0));
      polylines.add(Polyline(
        polylineId: PolylineId("myLocation"),
        points: points,
        color: Colors.blue,
      ));
      MyLocation = CameraPosition(
        target: LatLng(event.latitude ?? 0, event.longitude ?? 0),
        zoom: 18.4746,
      );
      setState(() {});
      print("lat: ${locationData?.latitude} long: ${locationData?.longitude}");
    });
  }

}

