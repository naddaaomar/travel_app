import 'package:flutter/material.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../data/model/fav_trip_model.dart';
import '../manager/favorites_cubit.dart';

class FavoriteTripCard extends StatelessWidget {
  final FavoriteModel trip;
  final VoidCallback onTap;

  const FavoriteTripCard({
    Key? key,
    required this.trip,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM d, yyyy');

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 120,
                  height: 100,
                  child: trip.coverImage != null
                      ? Image.network(
                    trip.coverImage!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey[200],
                      child: const Center(
                        child: Icon(
                            Icons.image,
                            size: 30,
                            color: Colors.grey),
                      ),
                    ),
                  )
                      : Container(
                    color: Colors.grey[200],
                    child: const Center(
                      child: Icon(
                          Icons.image,
                          size: 30,
                          color: Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trip.title,
                      style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'vols',
                          fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                            Icons.location_on,
                            size: 16,
                            color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          trip.destinationCity,
                          style: const TextStyle(
                              fontFamily: 'vols',
                              color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                            Icons.calendar_today,
                            size: 16,
                            color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          dateFormat.format(trip.startDate),
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              FavoriteButton(
                isFavorite: trip.isFavorite,
                iconSize: 40,
                valueChanged: (isFavorite) {
                  if (isFavorite) {
                    context.read<FavoritesCubit>().addFavorite(trip.id);
                  } else {
                    context.read<FavoritesCubit>().removeFavorite(trip.id);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}