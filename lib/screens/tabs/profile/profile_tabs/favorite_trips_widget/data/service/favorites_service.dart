import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/fav_trip_model.dart';

class FavoritesService {
  static const String _baseUrl = 'https://journeymate.runasp.net';
  static const Duration _timeout = Duration(seconds: 10);

  final http.Client client;

  FavoritesService({required this.client});

  Map<String, String> _buildHeaders(String token) => {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
  };

  Exception _handleError(dynamic response) {
    if (response is! http.Response) {
      return Exception('Unexpected error occurred');
    }
    try {
      final body = jsonDecode(response.body);
      final message = body['message'] ?? 'Error: ${response.statusCode}';
      return Exception(message);
    } catch (e) {
      return Exception('Error: ${response.statusCode}');
    }
  }

  Future<List<FavoriteModel>> getFavorites(String token) async {
    try {
      final response = await client
          .get(Uri.parse('$_baseUrl/api/Travel/Favtravels'),
          headers: _buildHeaders(token))
          .timeout(_timeout);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => FavoriteModel.fromJson(e)).toList();
      } else {
        throw _handleError(response);
      }
    } on TimeoutException {
      throw Exception('Request timed out');
    } on FormatException {
      throw Exception('Invalid response format');
    }
  }

  Future<void> addFavorite(String token, int travelId) async {
    try {
      final response = await client
          .post(
        Uri.parse('$_baseUrl/api/Travel/like/$travelId'),
        headers: _buildHeaders(token),
      )
          .timeout(_timeout);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw _handleError(response);
      }
    } on TimeoutException {
      throw Exception('Request timed out');
    }
  }

  Future<void> removeFavorite(String token, int travelId) async {
    try {
      final response = await client
          .delete(
        Uri.parse('$_baseUrl/api/Travel/like/$travelId'),
        headers: _buildHeaders(token),
      )
          .timeout(_timeout);

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw _handleError(response);
      }
    } on TimeoutException {
      throw Exception('Request timed out');
    }
  }
}