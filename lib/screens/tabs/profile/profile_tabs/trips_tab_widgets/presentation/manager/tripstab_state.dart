part of 'tripstab_cubit.dart';

abstract class TripsTabState extends Equatable {
  const TripsTabState();

  @override
  List<Object> get props => [];
}

class TripsTabInitial extends TripsTabState {}

class TripsTabLoading extends TripsTabState {}

class TripsTabLoaded extends TripsTabState {
  final List<Trip> trips;
  final bool hasReachedMax;

  const TripsTabLoaded({
    required this.trips,
    this.hasReachedMax = false,
  });

  @override
  List<Object> get props => [trips, hasReachedMax];

  TripsTabLoaded copyWith({
    List<Trip>? trips,
    bool? hasReachedMax,
  }) {
    return TripsTabLoaded(
      trips: trips ?? this.trips,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class TripsTabError extends TripsTabState {
  final String message;

  const TripsTabError(this.message);

  @override
  List<Object> get props => [message];
}

class RatingSubmitted extends TripsTabState {
  final int tripId;
  final double rating;

  const RatingSubmitted({
    required this.tripId,
    required this.rating,
  });

  @override
  List<Object> get props => [tripId, rating];
}

class RatingError extends TripsTabState {
  final String message;

  const RatingError(this.message);

  @override
  List<Object> get props => [message];
}