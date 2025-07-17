/*
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:p/screens/tabs/profile/profile_tabs/favorite_tabs/widgets/favorite_trips_widget/data/model/fav_trip_model.dart';
import '../../widgets/favorite_trips_widget/data/service/favorites_service.dart';
import '../../widgets/favorite_trips_widget/presentation/manager/favorites_cubit.dart';
import '../../widgets/favorite_trips_widget/presentation/manager/favorites_state.dart';
import '../../widgets/intersted_events_widget/data/model/interseted_event_model.dart';
import '../../widgets/intersted_events_widget/presentation/manager/interseted_cubit.dart';
import '../../widgets/intersted_events_widget/presentation/manager/interseted_state.dart';

part 'combined_favorites_state.dart';

class CombinedFavoritesCubit extends Cubit<CombinedFavoritesState> {
  final http.Client client;
  late InterestedEventsCubit interestedEventsCubit;
  late FavoritesCubit favoritesCubit;
  BuildContext? context;

  CombinedFavoritesCubit({required this.client}) : super(CombinedFavoritesInitial());

  void initialize(BuildContext context) {
    context = context;
    interestedEventsCubit = InterestedEventsCubit(client: client);
    favoritesCubit = FavoritesCubit(
      favoritesService: FavoritesService(client: client),
      secureStorage: const FlutterSecureStorage(),
    );

    interestedEventsCubit.stream.listen(_handleInterestedEventsStateChange);
    favoritesCubit.stream.listen(_handleFavoritesStateChange);

    // Add initial data fetch
    fetchAll();
  }
  void _handleInterestedEventsStateChange(InterestedEventsState state) {
    if (state is InterestedEventsLoading &&
        !(this.state is CombinedFavoritesLoading)) {
      emit(CombinedFavoritesLoading(
        events: _getCurrentEvents(),
        favorites: _getCurrentFavorites(),
      ));
      return;
    }

    if (state is InterestedEventsLoaded) {
      emit(CombinedFavoritesLoaded(
        events: state.events,
        favorites: _getCurrentFavorites(),
      ));
    } else if (state is InterestedEventsError) {
      emit(CombinedFavoritesError(
        'Interested Events Error: ${state.message}',
        events: _getCurrentEvents(),
        favorites: _getCurrentFavorites(),
      ));
    }
  }

  void _handleFavoritesStateChange(FavoritesState state) {
    if (state is FavoritesLoading &&
        !(this.state is CombinedFavoritesLoading)) {
      emit(CombinedFavoritesLoading(
        events: _getCurrentEvents(),
        favorites: _getCurrentFavorites(),
      ));
      return;
    }

    if (state is FavoritesLoaded) {
      emit(CombinedFavoritesLoaded(
        events: _getCurrentEvents(),
        favorites: state.favorites,
      ));
    } else if (state is FavoritesError) {
      emit(CombinedFavoritesError(
        'Favorites Error: ${state.message}',
        events: _getCurrentEvents(),
        favorites: _getCurrentFavorites(),
      ));
    }
  }

  List<InterstedEvents> _getCurrentEvents() {
    final currentState = state;
    if (currentState is CombinedFavoritesLoaded ||
        currentState is CombinedFavoritesError ||
        currentState is CombinedFavoritesLoading) {
      return currentState.events;
    }
    return [];
  }

  List<FavoriteModel> _getCurrentFavorites() {
    final currentState = state;
    if (currentState is CombinedFavoritesLoaded ||
        currentState is CombinedFavoritesError ||
        currentState is CombinedFavoritesLoading) {
      return currentState.favorites;
    }
    return [];
  }

  Future<void> fetchAll() async {
    emit(CombinedFavoritesLoading(
      events: _getCurrentEvents(),
      favorites: _getCurrentFavorites(),
    ));

    try {
      await Future.wait([
        interestedEventsCubit.fetchInterestedEvents(),
        favoritesCubit.loadFavorites(),
      ]);
    } catch (e) {
      emit(CombinedFavoritesError(
        'Failed to load data: $e',
        events: _getCurrentEvents(),
        favorites: _getCurrentFavorites(),
      ));
    }
  }

  Future<void> toggleEventInterest(InterstedEvents event) async {
    try {
      await interestedEventsCubit.toggleInterest(event);
    } catch (e) {
      emit(CombinedFavoritesError(
        'Failed to toggle interest: $e',
        events: _getCurrentEvents(),
        favorites: _getCurrentFavorites(),
      ));
    }
  }

  Future<void> toggleTripFavorite(FavoriteModel trip) async {
    try {
      if (trip.isFavorite) {
        await favoritesCubit.removeFavorite(trip.id);
      } else {
        await favoritesCubit.addFavorite(trip.id);
      }
    } catch (e) {
      emit(CombinedFavoritesError(
        'Failed to toggle favorite: $e',
        events: _getCurrentEvents(),
        favorites: _getCurrentFavorites(),
      ));
    }
  }

  Future<void> clearAllInterests() async {
    try {
      await interestedEventsCubit.clearAllInterests();
    } catch (e) {
      emit(CombinedFavoritesError(
        'Failed to clear interests: $e',
        events: _getCurrentEvents(),
        favorites: _getCurrentFavorites(),
      ));
    }
  }

  @override
  Future<void> close() {
    interestedEventsCubit.close();
    favoritesCubit.close();
    return super.close();
  }
}

 */