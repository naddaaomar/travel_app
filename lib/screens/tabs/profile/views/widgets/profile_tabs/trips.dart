import 'package:flutter/material.dart';
import 'trips_tab_widgets/trips.dart';

class PreviousTripsScreen extends StatelessWidget {
  const PreviousTripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: TripsPage(),
      ),
    );
  }
}
