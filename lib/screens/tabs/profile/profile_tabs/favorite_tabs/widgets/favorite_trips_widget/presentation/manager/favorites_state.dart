import '../../data/model/fav_trip_model.dart';

sealed class FavoritesState {
  const FavoritesState();
}

class FavoritesInitial extends FavoritesState {
  const FavoritesInitial();
}

class FavoritesLoading extends FavoritesState {
  const FavoritesLoading();
}

class FavoritesLoaded extends FavoritesState {
  final List<Trip> favorites;
  const FavoritesLoaded(this.favorites);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is FavoritesLoaded &&
              runtimeType == other.runtimeType &&
              favorites == other.favorites;

  @override
  int get hashCode => favorites.hashCode;
}

class FavoritesError extends FavoritesState {
  final String message;
  const FavoritesError(this.message);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is FavoritesError &&
              runtimeType == other.runtimeType &&
              message == other.message;

  @override
  int get hashCode => message.hashCode;
}