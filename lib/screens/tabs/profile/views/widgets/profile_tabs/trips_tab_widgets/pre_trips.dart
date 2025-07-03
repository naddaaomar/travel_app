import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:p/screens/tabs/profile/views/widgets/profile_tabs/trips_tab_widgets/model.dart';
import 'api.dart';
import 'no_trips.dart';

class PreviousTripsPage extends StatefulWidget {
  const PreviousTripsPage({super.key});

  @override
  State<PreviousTripsPage> createState() => _PreviousTripsPageState();
}

class _PreviousTripsPageState extends State<PreviousTripsPage> {
  late Future<List<Trip>> _previousTrips;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _previousTrips = _apiService.getPreviousTrips();
  }

  void _refreshTrips() {
    setState(() {
      _previousTrips = _apiService.getPreviousTrips();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Trip>>(
        future: _previousTrips,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const NoPreviousTrips();
          }
          else {
            return RefreshIndicator(
              onRefresh: () async => _refreshTrips(),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Trip trip = snapshot.data![index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            trip.destination,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Completed on: ${trip.endDate.toLocal().toString().split(' ')[0]}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(height: 12),
                          Center(
                            child: RatingBar.builder(
                              initialRating: trip.userRating ?? 0,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) async {
                                try {
                                  await _apiService.rateTrip(trip.id, rating);
                                  setState(() {
                                    trip.userRating = rating;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Successfully rated ${trip.destination}'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Failed to submit rating: Please try again.'),
                                      backgroundColor: Theme.of(context).colorScheme.error,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}