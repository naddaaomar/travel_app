part of 'travel_details_cubit.dart';

@immutable
class TravelDetailsState {
  final bool isLoading;
  final TravelDetailsModel? travelDetailsModel;
  final String? error;

  const TravelDetailsState({
    this.isLoading = false,
    this.travelDetailsModel,
    this.error,
  });

  TravelDetailsState copyWith({
    bool? isLoading,
    TravelDetailsModel? travelDetailsModel,
    String? error,
  }) {
    return TravelDetailsState(
      isLoading: isLoading ?? this.isLoading,
      travelDetailsModel: travelDetailsModel ?? this.travelDetailsModel,
      error: error,
    );
  }
}
