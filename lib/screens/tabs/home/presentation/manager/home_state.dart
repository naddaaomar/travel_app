part of 'home_cubit.dart';

@immutable
class HomeState {
  final bool isLoading;
  final bool hasError;
  final NewestModel? newestModel;
  final List<EventsModel?>? eventsModel;

  const HomeState({
    this.isLoading = false,
    this.hasError = false,
    this.newestModel,
    this.eventsModel,
  });

  HomeState copyWith({
    bool? isLoading,
    bool? hasError,
    NewestModel? newestModel,
    List<EventsModel?>? eventsModel,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      newestModel: newestModel ?? this.newestModel,
      eventsModel: eventsModel ?? this.eventsModel,
    );
  }
}