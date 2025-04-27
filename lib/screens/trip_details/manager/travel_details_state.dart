part of 'travel_details_cubit.dart';

@immutable
sealed class TravelDetailsState {}

final class TravelDetailsInitial extends TravelDetailsState {}

final class TravelDetailsLoading extends TravelDetailsState {}

final class TravelDetailsSuccess extends TravelDetailsState {
  TravelDetailsModel travelDetailsModel;

  TravelDetailsSuccess(this.travelDetailsModel);
}

final class TravelDetailsError extends TravelDetailsState {}
