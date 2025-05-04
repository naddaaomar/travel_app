import 'package:flutter/material.dart';
import 'package:p/screens/tabs/profile/views/widgets/profile_tabs/trips_tab_widgets/no_trips.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TripsPage extends StatefulWidget {
  const TripsPage({Key? key}) : super(key: key);

  @override
  State<TripsPage> createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage> {
  List<Map<String, dynamic>> _trips = [];
  bool _isLoading = true;
  bool _isFirstTime = true;

  @override
  void initState() {
    super.initState();
    _checkFirstTime();
    _loadTrips();
  }

  Future<void> _checkFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isFirstTime = prefs.getBool('is_first_time_trips') ?? true;
    });
  }

  Future<void> _loadTrips() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final tripData = prefs.getStringList('user_trips') ?? [];

      setState(() {
        _trips = tripData.map((trip) => {
          'id': trip.split('|')[0],
          'destination': trip.split('|')[1],
          'date': trip.split('|')[2],
          'status': trip.split('|')[3],
        }).toList();
        _isLoading = false;

        if (_trips.isNotEmpty) {
          _isFirstTime = false;
          prefs.setBool('is_first_time_trips', false);
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading trips: ${e.toString()}')),
      );
    }
  }

  Future<void> _addNewTrip(Map<String, dynamic> trip) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final newTrip = '${trip['id']}|${trip['destination']}|${trip['date']}|${trip['status']}';
      final updatedTrips = [...prefs.getStringList('user_trips') ?? [], newTrip];

      await prefs.setStringList('user_trips', updatedTrips);
      await prefs.setBool('is_first_time_trips', false);

      setState(() {
        _trips.add(trip);
        _isFirstTime = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('New trip to ${trip['destination']} added!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add trip: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Trips'),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _isFirstTime || _trips.isEmpty
          ? const NoPreviousTrips()
          : _buildTripsList(),
    );
  }

  Widget _buildTripsList() {
    return ListView.builder(
      itemCount: _trips.length,
      itemBuilder: (context, index) {
        final trip = _trips[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            title: Text(
              trip['destination'],
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Text(
              '${trip['date']} • ${trip['status']}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward_ios, size: 16),
              onPressed: () { // trip details
               },
            ),
          ),
        );
      },
    );
  }
}