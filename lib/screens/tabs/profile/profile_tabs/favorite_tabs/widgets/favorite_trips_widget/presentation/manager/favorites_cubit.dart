import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../data/model/fav_trip_model.dart';
import '../../data/service/favorites_service.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final http.Client client;
  late final FavoritesService _service;

  FavoritesCubit({required this.client}) : super(FavoritesInitial()) {
    _service = FavoritesService(client: client);
    fetchFavorites();
  }

  Future<void> fetchFavorites() async {
    emit(FavoritesLoading());
    try {
      final favorites = await _service.getFavorites();
      emit(FavoritesLoaded(favorites));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> toggleFavorite(Trip trip) async {
    print(' Toggle favorite called for trip: ${trip.id}');
    final currentState = state;

    if (currentState is FavoritesLoaded) {
      try {
        final isRemoving = trip.isFavorite;
        print(isRemoving
            ? ' Removing trip from favorites: ${trip.id}'
            : ' Adding trip to favorites: ${trip.id}');

        final updatedFavorites = isRemoving
            ? currentState.favorites.where((t) => t.id != trip.id).toList()
            : [...currentState.favorites, trip.copyWith(isFavorite: true)];

        print(' Updated favorites count: ${updatedFavorites.length}');
        emit(FavoritesLoaded(updatedFavorites));

        final success = await _service.toggleFavorite(trip.id);

        if (!success) {
          print(' Failed to update favorite on server. Reverting state.');
          emit(FavoritesLoaded(currentState.favorites));
          throw Exception('Failed to update favorites on server');
        } else {
          print(' Server updated successfully.');
        }

      } catch (e) {
        print('Error toggling favorite: $e');
        emit(FavoritesError(e.toString()));
        emit(FavoritesLoaded(currentState.favorites));
      }
    }
  }
}