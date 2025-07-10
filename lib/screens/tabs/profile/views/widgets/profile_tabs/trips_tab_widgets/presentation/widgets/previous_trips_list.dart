import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:p/screens/tabs/profile/views/widgets/profile_tabs/trips_tab_widgets/data/model/trips_tab_model.dart';
import 'package:p/screens/tabs/profile/views/widgets/profile_tabs/trips_tab_widgets/presentation/widgets/no_previous_trips.dart';
import 'previous_trips_card.dart';

class TripList extends StatelessWidget {
  final List<Trip> trips;
  final DateFormat dateFormat;
  final Function(Trip, double) onRateTrip;

  const TripList({
    super.key,
    required this.trips,
    required this.dateFormat,
    required this.onRateTrip,
  });

  @override
  Widget build(BuildContext context) {
    if (trips.isEmpty) {
      return const Center(
        child: NoPreviousTrips(),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: trips.length,
      separatorBuilder: (context, index) =>
        const SizedBox(
          height: 16),
      itemBuilder: (context, index) {
        final trip = trips[index];
        return TripCard(
          trip: trip,
          dateFormat: dateFormat,
          onRateTrip: onRateTrip,
        );
      },
    );
  }
}