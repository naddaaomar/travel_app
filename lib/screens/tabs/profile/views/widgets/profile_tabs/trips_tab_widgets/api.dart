import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:p/screens/tabs/profile/views/widgets/profile_tabs/trips_tab_widgets/model.dart';

class ApiService {
  final String baseUrl = "https://journeymate.runasp.net/api";

  Future<List<Trip>> getPreviousTrips() async {
    final response = await http.get(Uri.parse('$baseUrl/Trips/GetPreviousTrips'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Trip> trips = body .where((dynamic item) => DateTime.parse(item['endDate']).isBefore(DateTime.now()))
          .map((dynamic item) => Trip.fromJson(item))
          .toList();
       return trips;
    } else {
      throw Exception('Failed to load previous trips');
    }
  }

  Future<void> rateTrip(int tripId, double rating) async {
    final response = await http.post(
      Uri.parse('$baseUrl/Trips/RateTrip'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'tripId': tripId,
        'rating': rating,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to submit rating. Status code: ${response.statusCode}');
    }
  }
}