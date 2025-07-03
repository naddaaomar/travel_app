/*
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'no_trips.dart';


class PreviousTrips extends StatefulWidget {
  @override
  _PreviousTripsPageState createState() => _PreviousTripsPageState();
}

class _PreviousTripsPageState extends State<PreviousTrips> {
  List<Trip> _allTrips = [
    Trip(
      id: '1',
      title: 'Beach Vacation',
      destination: 'Maldives',
      imageUrl: 'https://example.com/maldives.jpg',
      startDate: DateTime.now().subtract(Duration(days: 15)),
      endDate: DateTime.now().subtract(Duration(days: 8)),
      isCompleted: true,
      userRating: 0, // 0 means not rated yet
    ),
    Trip(
      id: '2',
      title: 'Mountain Hiking',
      destination: 'Swiss Alps',
      imageUrl: 'https://example.com/alps.jpg',
      startDate: DateTime.now().subtract(Duration(days: 30)),
      endDate: DateTime.now().subtract(Duration(days: 23)),
      isCompleted: true,
      userRating: 4,
    ),
    Trip(
      id: '3',
      title: 'City Tour',
      destination: 'Paris',
      imageUrl: 'https://example.com/paris.jpg',
      startDate: DateTime.now().add(Duration(days: 5)),
      endDate: DateTime.now().add(Duration(days: 12)),
      isCompleted: false,
      userRating: 0,
    ),
  ];

  List<Trip> get _completedTrips {
    final now = DateTime.now();
    return _allTrips.where((trip) => trip.endDate.isBefore(now) && trip.isCompleted).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _completedTrips.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            NoPreviousTrips(),
          ],
        ),
      )
          : ListView.builder(
        itemCount: _completedTrips.length,
        itemBuilder: (context, index) {
          final trip = _completedTrips[index];
          return _buildTripCard(trip);
        },
      ),
    );
  }

  Widget _buildTripCard(Trip trip) {
    final dateFormat = DateFormat('MMM dd, yyyy');

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              trip.imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 180,
                color: Colors.grey[200],
                child: Icon(Icons.image, size: 64, color: Colors.grey),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trip.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  trip.destination,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                    SizedBox(width: 4),
                    Text(
                      '${dateFormat.format(trip.startDate)} - ${dateFormat.format(trip.endDate)}',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                if (trip.userRating > 0)
                  Row(
                    children: [
                      Text(
                        'Your rating: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      _buildRatingStars(trip.userRating, false),
                    ],
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rate this trip:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      _buildRatingStars(0, true),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingStars(int currentRating, bool interactive) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: interactive
              ? () {
            // Update the rating
            setState(() {
              _allTrips = _allTrips.map((t) {
                if (t.id == _completedTrips
                    .firstWhere((ct) => ct.userRating == currentRating)
                    .id) {
                  return t.copyWith(userRating: index + 1);
                }
                return t;
              }).toList();
            });

            // In a real app, you would send this rating to your backend
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Thanks for your rating!'),
                duration: Duration(seconds: 2),
              ),
            );
          }
              : null,
          child: Icon(
            index < currentRating ? Icons.star : Icons.star_border,
            color: Colors.amber,
            size: 32,
          ),
        );
      }),
    );
  }
}

class Trip {
  final String id;
  final String title;
  final String destination;
  final String imageUrl;
  final DateTime startDate;
  final DateTime endDate;
  final bool isCompleted;
  final int userRating; // 1-5, 0 means not rated

  Trip({
    required this.id,
    required this.title,
    required this.destination,
    required this.imageUrl,
    required this.startDate,
    required this.endDate,
    required this.isCompleted,
    required this.userRating,
  });

  Trip copyWith({
    String? id,
    String? title,
    String? destination,
    String? imageUrl,
    DateTime? startDate,
    DateTime? endDate,
    bool? isCompleted,
    int? userRating,
  }) {
    return Trip(
      id: id ?? this.id,
      title: title ?? this.title,
      destination: destination ?? this.destination,
      imageUrl: imageUrl ?? this.imageUrl,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isCompleted: isCompleted ?? this.isCompleted,
      userRating: userRating ?? this.userRating,
    );
  }
}
*/
