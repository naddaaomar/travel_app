import 'package:flutter/material.dart';

import 'widgets/map_body.dart';

class MapView extends StatefulWidget {
   MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    return MapBody();
  }
}
