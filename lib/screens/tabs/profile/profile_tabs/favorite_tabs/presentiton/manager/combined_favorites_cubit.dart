import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../widgets/favorite_trips_widget/data/model/fav_trip_model.dart';
import '../../widgets/favorite_trips_widget/presentation/manager/favorites_cubit.dart';
import '../../widgets/favorite_trips_widget/presentation/manager/favorites_state.dart';
import '../../widgets/intersted_events_widget/data/model/interseted_event_model.dart';
import '../../widgets/intersted_events_widget/presentation/manager/interseted_cubit.dart';
import '../../widgets/intersted_events_widget/presentation/manager/interseted_state.dart';

part 'combined_favorites_state.dart';

class CombinedFavoritesCubit extends Cubit<CombinedFavoritesState> {
  final InterestedEventsCubit interestedEventsCubit;
  final FavoritesCubit favoritesCubit;

  CombinedFavoritesCubit({
    required http.Client client,
  })  : interestedEventsCubit = InterestedEventsCubit(client: client),
        favoritesCubit = FavoritesCubit(client: client),
        super(CombinedFavoritesInitial()) {
    interestedEventsCubit.stream.listen(_handleInterestedEventsStateChange);
    favoritesCubit.stream.listen(_handleFavoritesStateChange);

    fetchAll();
  }

  void _handleInterestedEventsStateChange(InterestedEventsState state) {
    final currentFavorites = _getCurrentFavorites();

    if (state is InterestedEventsLoaded) {
      emit(CombinedFavoritesLoaded(
        events: state.events,
        favorites: currentFavorites,
      ));
    } else if (state is InterestedEventsError) {
      emit(CombinedFavoritesError(
        'Interested Events Error: ${state.message}',
        events: _getCurrentEvents(),
        favorites: currentFavorites,
      ));
    }
  }

  void _handleFavoritesStateChange(FavoritesState state) {
    final currentEvents = _getCurrentEvents();

    if (state is FavoritesLoaded) {
      emit(CombinedFavoritesLoaded(
        events: currentEvents,
        favorites: state.favorites,
      ));
    } else if (state is FavoritesError) {
      emit(CombinedFavoritesError(
        'Favorites Error: ${state.message}',
        events: currentEvents,
        favorites: _getCurrentFavorites(),
      ));
    }
  }

  List<InterstedEvents> _getCurrentEvents() {
    final currentState = state;
    if (currentState is CombinedFavoritesLoaded ||
        currentState is CombinedFavoritesError) {
      return currentState.events;
    }
    return [];
  }

  List<Trip> _getCurrentFavorites() {
    final currentState = state;
    if (currentState is CombinedFavoritesLoaded ||
        currentState is CombinedFavoritesError) {
      return currentState.favorites;
    }
    return [];
  }

  Future<void> fetchAll() async {
    await Future.wait([
      interestedEventsCubit.fetchInterestedEvents(),
      favoritesCubit.fetchFavorites(),
    ]);
  }

  Future<void> toggleEventInterest(InterstedEvents event) async {
    await interestedEventsCubit.toggleInterest(event);
  }

  Future<void> toggleTripFavorite(Trip trip) async {
    await favoritesCubit.toggleFavorite(trip);
  }

  Future<void> clearAllInterests() async {
    await interestedEventsCubit.clearAllInterests();
  }

  @override
  Future<void> close() {
    interestedEventsCubit.close();
    favoritesCubit.close();
    return super.close();
  }
}