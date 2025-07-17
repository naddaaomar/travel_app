import 'package:flutter/material.dart';
import 'package:p/screens/trip_details/views/trip_details_view_body.dart';
import '../../../../../../../../all_travels/presentation/pages/all_travels.dart';
import '../../data/model/fav_trip_model.dart';
import 'favorite_trip_card.dart';
import 'no_favorites.dart';

class FavoriteList extends StatelessWidget {
  final List<Trip> favorites;
  final Function(Trip) onToggleFavorite;

  const FavoriteList({
    super.key,
    required this.favorites,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    if (favorites.isEmpty) {
      return NoFavorites(
        onAddFavorite: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AllTravels()));
        },
      );
    }

    return ListView.builder(
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final trip = favorites[index];
        return FavoriteTripCard(
          trip: trip,
          onToggleFavorite: (tripToRemove) {
            onToggleFavorite(tripToRemove);
          },
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => TripDetailsViewBody(
                    id: trip.id.toString()),
              ),
            );
          },
        );
      },
    );
  }
}