import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TripsPage extends StatefulWidget {
  const TripsPage({super.key});

  @override
  State<TripsPage> createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage> {
  List<Trip> _trips = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTrips();
  }

  Future<void> _loadTrips() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final tripStrings = prefs.getStringList('user_trips') ?? [];

      final loadedTrips = <Trip>[];
      for (final str in tripStrings) {
        final trip = Trip.tryParse(str);
        if (trip != null) {
          loadedTrips.add(trip);
        }
      }

      setState(() {
        _trips = loadedTrips;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      _showError('Error loading trips: ${e.toString()}');
    }
  }

  Future<void> _saveTrips() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(
        'user_trips',
        _trips.map((t) => t.toString()).toList(),
      );
    } catch (e) {
      _showError('Failed to save trips: ${e.toString()}');
    }
  }

  Future<void> _addTrip(Trip trip) async {
    setState(() => _trips = [..._trips, trip]);
    await _saveTrips();
    _showSuccess('Added trip to ${trip.destination}');
  }

  Future<void> _deleteTrip(String id) async {
    setState(() => _trips = _trips.where((t) => t.id != id).toList());
    await _saveTrips();
    _showSuccess('Trip deleted');
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _navigateToAddTrip() async {
    final result = await Navigator.push<Trip>(
      context,
      MaterialPageRoute(
        builder: (context) => const AddTripPage(),
      ),
    );

    if (result != null) {
      await _addTrip(result);
    }
  }

  void _showTripDetails(Trip trip) {
    showModalBottomSheet(
      context: context,
      builder: (context) => TripDetailsSheet(trip: trip),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Trips'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _navigateToAddTrip,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _trips.isEmpty
          ? const NoTripsWidget()
          : ListView.builder(
        itemCount: _trips.length,
        itemBuilder: (context, index) {
          final trip = _trips[index];
          return Dismissible(
            key: Key(trip.id),
            background: Container(color: Colors.red),
            onDismissed: (_) => _deleteTrip(trip.id),
            child: Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                title: Text(trip.destination),
                subtitle: Text('${trip.date} • ${trip.status}'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showTripDetails(trip),
              ),
            ),
          );
        },
      ),
      floatingActionButton: _trips.isEmpty
          ? FloatingActionButton(
        onPressed: _navigateToAddTrip,
        child: const Icon(Icons.add),
      )
          : null,
    );
  }
}

@immutable
class Trip {
  final String id;
  final String destination;
  final String date;
  final String status;

  const Trip({
    required this.id,
    required this.destination,
    required this.date,
    required this.status,
  });

  factory Trip.tryParse(String str) {
      final parts = str.split('|');

      return Trip(
        id: parts[0],
        destination: parts[1],
        date: parts[2],
        status: parts[3],
      );

  }

  @override
  String toString() => '$id|$destination|$date|$status';
}

class AddTripPage extends StatefulWidget {
  const AddTripPage({super.key});

  @override
  State<AddTripPage> createState() => _AddTripPageState();
}

class _AddTripPageState extends State<AddTripPage> {
  final _formKey = GlobalKey<FormState>();
  final _destinationController = TextEditingController();
  final _dateController = TextEditingController();
  final _statusController = TextEditingController();

  @override
  void dispose() {
    _destinationController.dispose();
    _dateController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Trip'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _submitForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _destinationController,
                decoration: const InputDecoration(labelText: 'Destination'),
                validator: (value) =>
                value?.isEmpty ?? true ? 'Required field' : null,
              ),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(labelText: 'Date'),
                validator: (value) =>
                value?.isEmpty ?? true ? 'Required field' : null,
              ),
              TextFormField(
                controller: _statusController,
                decoration: const InputDecoration(labelText: 'Status'),
                validator: (value) =>
                value?.isEmpty ?? true ? 'Required field' : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final newTrip = Trip(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        destination: _destinationController.text,
        date: _dateController.text,
        status: _statusController.text,
      );
      Navigator.pop(context, newTrip);
    }
  }
}

class TripDetailsSheet extends StatelessWidget {
  final Trip trip;

  const TripDetailsSheet({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            trip.destination,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text('Date: ${trip.date}'),
          Text('Status: ${trip.status}'),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CLOSE'),
            ),
          ),
        ],
      ),
    );
  }
}

class NoTripsWidget extends StatelessWidget {
  const NoTripsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.travel_explore, size: 64),
          const SizedBox(height: 16),
          const Text('No trips yet'),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => Navigator.push<Trip>(
              context,
              MaterialPageRoute(
                builder: (context) => const AddTripPage(),
              ),
            ),
            child: const Text('ADD YOUR FIRST TRIP'),
          ),
        ],
      ),
    );
  }
}