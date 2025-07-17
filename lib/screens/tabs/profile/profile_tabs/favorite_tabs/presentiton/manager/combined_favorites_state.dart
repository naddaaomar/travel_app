/*
part of 'combined_favorites_cubit.dart';

@immutable
sealed class CombinedFavoritesState extends Equatable {
  final List<InterstedEvents> events;
  final List<FavoriteModel> favorites;

  const CombinedFavoritesState({
    this.events = const [],
    this.favorites = const [],
  });

  @override
  List<Object> get props => [events, favorites];

  bool get isLoading => this is CombinedFavoritesLoading;
  bool get isLoaded => this is CombinedFavoritesLoaded;
  bool get isError => this is CombinedFavoritesError;
}

class CombinedFavoritesInitial extends CombinedFavoritesState {
  const CombinedFavoritesInitial() : super();

  @override
  List<Object> get props => [...super.props, runtimeType];
}

class CombinedFavoritesLoading extends CombinedFavoritesState {
  const CombinedFavoritesLoading({
    required List<InterstedEvents> events,
    required List<FavoriteModel> favorites,
  }) : super(events: events, favorites: favorites);

  @override
  List<Object> get props => [...super.props, runtimeType];
}

class CombinedFavoritesLoaded extends CombinedFavoritesState {
  const CombinedFavoritesLoaded({
    required List<InterstedEvents> events,
    required List<FavoriteModel> favorites,
  }) : super(events: events, favorites: favorites);

  @override
  List<Object> get props => [...super.props, runtimeType];

  CombinedFavoritesLoaded copyWith({
    List<InterstedEvents>? events,
    List<FavoriteModel>? favorites,
  }) {
    return CombinedFavoritesLoaded(
      events: events ?? this.events,
      favorites: favorites ?? this.favorites,
    );
  }
}

class CombinedFavoritesError extends CombinedFavoritesState {
  final String message;
  final DateTime timestamp;

  CombinedFavoritesError(
      this.message, {
        required List<InterstedEvents> events,
        required List<FavoriteModel> favorites,
      })  : timestamp = DateTime.now(),
        super(events: events, favorites: favorites);

  @override
  List<Object> get props => [...super.props, message, timestamp, runtimeType];

  CombinedFavoritesError copyWith({
    String? message,
    List<InterstedEvents>? events,
    List<FavoriteModel>? favorites,
  }) {
    return CombinedFavoritesError(
      message ?? this.message,
      events: events ?? this.events,
      favorites: favorites ?? this.favorites,
    );
  }
}

 */