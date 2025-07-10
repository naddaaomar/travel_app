part of 'event_details_cubit.dart';

@immutable
class EventDetailsState {
  final bool isLoading;
  final bool hasError;
  final EventDetailsModel? detailsModel;
  final bool isDescriptionExpanded;

  const EventDetailsState({
    this.isLoading = false,
    this.hasError = false,
    this.detailsModel,
    this.isDescriptionExpanded = false,
  });

  EventDetailsState copyWith({
    bool? isLoading,
    bool? hasError,
    EventDetailsModel? detailsModel,
    bool? isDescriptionExpanded,
  }) {
    return EventDetailsState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      detailsModel: detailsModel ?? this.detailsModel,
      isDescriptionExpanded:
      isDescriptionExpanded ?? this.isDescriptionExpanded,
    );
  }
}
