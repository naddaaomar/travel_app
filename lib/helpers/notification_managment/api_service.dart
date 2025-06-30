import 'dart:convert';
import 'package:http/http.dart' as http;

class TripService {
  final String baseUrl = 'https://journeymate.runasp.net/api/Trip';

  Future<Map<String, dynamic>> getTripDetails(String tripId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$tripId'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load trip details');
    }
  }
}