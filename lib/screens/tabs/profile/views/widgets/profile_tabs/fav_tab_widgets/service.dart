import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/screens/tabs/profile/views/widgets/profile_tabs/fav_tab_widgets/modelllll.dart';
import 'api_favtab.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final ApiService _apiService;

  FavoritesCubit(this._apiService) : super(FavoritesInitial());

  Future<void> loadFavorites() async {
    emit(FavoritesLoading());
    try {
      final favorites = await _apiService.getFavorites();
      emit(FavoritesLoaded(favorites));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> toggleFavorite(String tripId) async {
    try {
      final success = await _apiService.toggleFavorite(tripId);
      if (success) {
        if (state is FavoritesLoaded) {
          final currentFavorites = (state as FavoritesLoaded).favorites;
          final exists = currentFavorites.any((trip) => trip.id == tripId);
          if (exists) {
            final newFavorites = currentFavorites.where((trip) => trip.id != tripId).toList();
            emit(FavoritesLoaded(newFavorites));
          } else {
            await loadFavorites();
          }
        }
      }
    } catch (e) {
      emit(FavoritesError(e.toString()));
      await Future.delayed(const Duration(seconds: 2));
      loadFavorites();
    }
  }
}

abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}
class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<Trip> favorites;
  FavoritesLoaded(this.favorites);
}

class FavoritesError extends FavoritesState {
  final String message;
  FavoritesError(this.message);
}