import 'package:flutter/material.dart';
import 'views/widgets/trip_details_view_body.dart';

class TripDetailsView extends StatelessWidget {
  const TripDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: TripDetailsViewBody(image: '', tripId: '',),
      ),
    );
  }
}