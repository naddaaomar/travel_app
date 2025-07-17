part of 'combined_favorites_cubit.dart';

sealed class CombinedFavoritesState {
  final List<InterstedEvents> events;
  final List<Trip> favorites;

  const CombinedFavoritesState({
    this.events = const [],
    this.favorites = const [],
  });
}

class CombinedFavoritesInitial extends CombinedFavoritesState {
  const CombinedFavoritesInitial() : super();
}

class CombinedFavoritesLoaded extends CombinedFavoritesState {
  const CombinedFavoritesLoaded({
    required List<InterstedEvents> events,
    required List<Trip> favorites,
  }) : super(events: events, favorites: favorites);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CombinedFavoritesLoaded &&
              runtimeType == other.runtimeType &&
              events == other.events &&
              favorites == other.favorites;

  @override
  int get hashCode => Object.hash(events, favorites);
}

class CombinedFavoritesError extends CombinedFavoritesState {
  final String message;

  const CombinedFavoritesError(
      this.message, {
        required List<InterstedEvents> events,
        required List<Trip> favorites,
      }) : super(events: events, favorites: favorites);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CombinedFavoritesError &&
              runtimeType == other.runtimeType &&
              message == other.message &&
              events == other.events &&
              favorites == other.favorites;

  @override
  int get hashCode => Object.hash(message, events, favorites);
}