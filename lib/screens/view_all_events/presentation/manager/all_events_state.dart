part of 'all_events_cubit.dart';


@immutable
class AllEventsState {
  final bool isLoading;
  final bool hasError;
  final List<EventsModel?>? eventsModel;

  const AllEventsState({
    this.isLoading = false,
    this.hasError = false,
    this.eventsModel,
  });

  AllEventsState copyWith({
    bool? isLoading,
    bool? hasError,
    List<EventsModel?>? eventsModel,
  }) {
    return AllEventsState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      eventsModel: eventsModel ?? this.eventsModel,
    );
  }
}
