part of 'travel_details_cubit.dart';

@immutable
class TravelDetailsState {
  final bool isLoading;
  final TravelDetailsModel? travelDetailsModel;
  final String? error;
  final bool isDescriptionExpanded;

  const TravelDetailsState({
    this.isLoading = false,
    this.travelDetailsModel,
    this.error,
    this.isDescriptionExpanded = false,
  });

  TravelDetailsState copyWith({
    bool? isLoading,
    TravelDetailsModel? travelDetailsModel,
    String? error,
    bool? isDescriptionExpanded,
  }) {
    return TravelDetailsState(
      isLoading: isLoading ?? this.isLoading,
      travelDetailsModel: travelDetailsModel ?? this.travelDetailsModel,
      error: error,
      isDescriptionExpanded:
      isDescriptionExpanded ?? this.isDescriptionExpanded,
    );
  }
}
