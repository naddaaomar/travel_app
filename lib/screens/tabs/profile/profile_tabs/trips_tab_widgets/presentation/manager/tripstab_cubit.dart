import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:p/helpers/constants/constants.dart';
import '../../data/model/trips_tab_model.dart';

part 'tripstab_state.dart';

class TripsTabCubit extends Cubit<TripsTabState> {
  final http.Client client;
  final String baseUrl = Constants.baseURL;
  final Map<int, double> _localRatings = {};       // Local rating storage

  TripsTabCubit({required this.client}) : super(TripsTabInitial());

  Future<void> fetchTrips() async {
    try {
      emit(TripsTabLoading());

      final response = await client.get(
        Uri.parse('$baseUrl/api/Booking'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> bookingsJson = json.decode(response.body);
        final List<BookingModel> bookings = bookingsJson
            .map((json) => BookingModel.fromJson(json))
            .toList();

        final List<Trip> trips = bookings
            .map((booking) {
          final trip = Trip.fromBookingModel(booking);
          return trip.copyWith(userRating: _localRatings[trip.id]);
        }) .where((trip) => trip.isCompleted).toList();

        if (trips.isEmpty) {
          emit(TripsTabError('No completed trips found'));
        } else {
          emit(TripsTabLoaded(trips: trips));
        }
      } else {
        emit(TripsTabError('Failed to load trips: ${response.statusCode}'));
      }
    } catch (e) {
      emit(TripsTabError('Failed to fetch trips: $e'));
    }
  }

  // LOCAL
  Future<void> rateTrip(Trip trip, double rating) async {
    try {
      emit(TripsTabLoading());
      _localRatings[trip.id] = rating;

      final updatedTrip = trip.copyWith(userRating: rating);

      if (state is TripsTabLoaded) {
        final currentState = state as TripsTabLoaded;
        final updatedTrips = currentState.trips.map((t) =>
        t.id == trip.id ? updatedTrip : t).toList();

        emit(currentState.copyWith(trips: updatedTrips));
        emit(RatingSubmitted(tripId: trip.id, rating: rating));
      }
    } catch (e) {
      emit(TripsTabError(e.toString()));
      emit(RatingError(e.toString()));
    }
  }
}