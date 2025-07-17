import 'package:flutter/material.dart';
import '../../../../../../trip_details/views/trip_details_view_body.dart';
import '../../data/model/fav_trip_model.dart';
import 'favorite_trip_card.dart';

class FavoriteList extends StatelessWidget {
  final List<FavoriteModel> favorites;

  const FavoriteList({
    super.key,
    required this.favorites,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final trip = favorites[index];
        return FavoriteTripCard(
          trip: trip,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => TripDetailsViewBody(id: trip.id.toString()),
              ),
            );
          },
        );
      },
    );
  }
}