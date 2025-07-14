part of 'home_cubit.dart';

@immutable
class HomeState {
  final bool isLoading;
  final bool hasError;
  final NewestModel? newestModel;
  final List<EventsModel?>? eventsModel;
  final List<EventRecommendation>? eventRecommendation;
  final List<TravelRecommendation>? travelRecommendation;
  final String? token; // ✅ NEW

  const HomeState({
    this.isLoading = false,
    this.hasError = false,
    this.newestModel,
    this.eventsModel,
    this.eventRecommendation,
    this.travelRecommendation,
    this.token, // ✅ NEW
  });

  HomeState copyWith({
    bool? isLoading,
    bool? hasError,
    NewestModel? newestModel,
    List<EventsModel?>? eventsModel,
    List<EventRecommendation>? eventRecommendation,
    List<TravelRecommendation>? travelRecommendation,
    String? token, // ✅ NEW
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      newestModel: newestModel ?? this.newestModel,
      eventsModel: eventsModel ?? this.eventsModel,
      eventRecommendation: eventRecommendation ?? this.eventRecommendation,
      travelRecommendation: travelRecommendation ?? this.travelRecommendation,
      token: token ?? this.token, // ✅ NEW
    );
  }
}
