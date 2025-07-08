import 'dart:convert';
import 'package:http/http.dart' as http;
import 'trip.dart';

class ApiService {
  static const String _baseUrl = 'https://journeymate.runasp.net/api/Trip';

  Future<Trip> getTripDetails(String tripId) async {
    final uri = Uri.parse('$_baseUrl/$tripId');

    try {
      final response = await http.get(
        uri,
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        return Trip.fromJson(data, tripId: tripId);
      } else {
        throw Exception('Failed to load trip details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load trip details: $e');
    }
  }
}
