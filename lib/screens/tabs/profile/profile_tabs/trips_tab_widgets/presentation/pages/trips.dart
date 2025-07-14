import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../manager/tripstab_cubit.dart';
import '../widgets/no_previous_trips.dart';
import '../widgets/previous_trips_list.dart';

class PreviousTripsPage extends StatelessWidget {
  final DateFormat _dateFormat = DateFormat('MMM dd, yyyy');

    PreviousTripsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TripsTabCubit(
          client: http.Client())..fetchTrips(),
      child: Scaffold(
        body: BlocConsumer<TripsTabCubit, TripsTabState>(
          listener: (context, state) {
            if (state is RatingError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is RatingSubmitted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Rating submitted successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is TripsTabLoading || state is TripsTabInitial) {
              return const Center(
                  child: CircularProgressIndicator()
              );
            } else if (state is TripsTabLoaded) {
              if (state.trips.isEmpty) {
                return const NoPreviousTrips();
              }
              return RefreshIndicator(
                onRefresh: () => context.read<TripsTabCubit>().fetchTrips(),
                child: TripList(
                  trips: state.trips,
                  dateFormat: _dateFormat,
                  onRateTrip: (trip, rating) {
                    context.read<TripsTabCubit>().rateTrip(trip, rating);
                  },
                ),
              );
            }
            return const NoPreviousTrips();
          },
        ),
      ),
    );
  }
}