import 'package:flutter/material.dart';
import 'package:p/screens/tabs/profile/views/widgets/profile_tabs/trips_tab_widgets/no_trips.dart';
import 'package:shared_preferences/shared_preferences.dart';

class tripsPage extends StatefulWidget {
  const tripsPage({Key? key}) : super(key: key);

  @override
  _TripsPageState createState() => _TripsPageState();
}

class _TripsPageState extends State<tripsPage> {
  bool _isFirstTime = true;

  @override
  void initState() {
    super.initState();
    _checkFirstTime();
  }

  Future<void> _checkFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isFirstTime = prefs.getBool('notFirstTime') ?? true;
    });
    if (_isFirstTime) {
      prefs.setBool('notFirstTime', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isFirstTime
            ? const NoPreviousTrips()
            : _buildTripsList(),
      ),
    );
  }

  Widget _buildTripsList() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text('Trip ${index + 1}',style: TextStyle(fontFamily: "pop"),),

          ),
        );
      },
    );
  }
}
