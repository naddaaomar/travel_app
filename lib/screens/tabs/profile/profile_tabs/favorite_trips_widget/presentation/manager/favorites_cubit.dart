import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../data/service/favorites_service.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesService favoritesService;
  final FlutterSecureStorage secureStorage;
  BuildContext? _context;


  FavoritesCubit({
    required this.favoritesService,
    required this.secureStorage,
  }) : super(FavoritesInitial()) {
    loadFavorites(); // 👈 call immediately
  }

  Future<void> loadFavorites() async {
    try {
     // emit(FavoritesLoading());
      final token = await secureStorage.read(key: 'token');
      if (token == null) {
        _showAuthRequired();
        emit(const FavoritesError('Authentication required'));
        return;
      }
      final favorites = await favoritesService.getFavorites(token);
      emit(FavoritesLoaded(favorites));
    } catch (e) {
      emit(FavoritesError(e.toString()));
      _showError(e.toString());
    }
  }

  Future<void> addFavorite(int travelId) async {
    try {
      final token = await secureStorage.read(key: 'token');
      if (token == null) {
        _showAuthRequired();
        return;
      }
      await favoritesService.addFavorite(token, travelId);
      await loadFavorites();
    } catch (e) {
      emit(FavoritesError('Failed to add favorite: $e'));
      _showError('Failed to add favorite');
    }
  }

  Future<void> removeFavorite(int travelId) async {
    try {
     // emit(FavoritesLoading());
      final token = await secureStorage.read(key: 'token');
      if (token == null) {
        _showAuthRequired();
        return;
      }
      await favoritesService.removeFavorite(token, travelId);

      if (state is FavoritesLoaded) {
        final currentFavorites = (state as FavoritesLoaded).favorites;
        final updatedFavorites = currentFavorites.where((f) => f.id != travelId).toList();
        emit(FavoritesLoaded(updatedFavorites));
      } else {
        await loadFavorites();
      }
    } catch (e) {
      emit(FavoritesError('Failed to remove favorite: $e'));
      _showError('Failed to remove favorite');
    }
  }

  void _showAuthRequired() {
    if (_context != null && _context!.mounted) {
      ScaffoldMessenger.of(_context!).showSnackBar(
        const SnackBar(content: Text('Please sign in to manage favorites')),
      );
    }
  }

  void _showError(String message) {
    if (_context != null && _context!.mounted) {
      ScaffoldMessenger.of(_context!).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  Future<void> close() {
    _context = null;
    return super.close();
  }
}