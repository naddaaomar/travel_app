import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:p/screens/auth/core/cubit/auth_cubit.dart';
import 'package:p/screens/auth/core/cubit/auth_state.dart';
import '../model/fav_trip_model.dart';

class FavoritesService {
  static const String _baseUrl = 'https://journeymate.runasp.net';
  static const Duration _timeout = Duration(seconds: 10);

  final http.Client client;
  final AuthCubit _authCubit;

  FavoritesService({required this.client, AuthCubit? authCubit})
      : _authCubit = authCubit ?? AuthCubit();


  Future<List<Trip>> getFavorites() async {
    try {
      final token = _getAuthToken();
      if (token == null) throw Exception('Authentication required');

      final response = await client.get(
        Uri.parse('$_baseUrl/api/Favorites'),
        headers: _buildHeaders(token),
      ).timeout(_timeout);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => Trip.fromJson(item)).toList();
      }
      throw _handleError(response);
    } on http.ClientException catch (e) {
      throw Exception('Network error: ${e.message}');
    } on TimeoutException {
      throw Exception('Request timed out');
    } on FormatException {
      throw Exception('Invalid response format');
    } catch (e) {
      throw Exception('Failed to load favorites: ${e.toString()}');
    }
  }



  Future<bool> toggleFavorite(int tripId) async {
    try {
      final token = _getAuthToken();
      if (token == null) return false;

      final response = await client.post(
        Uri.parse('$_baseUrl/api/Favorites/toggle/$tripId'),
        headers: _buildHeaders(token),
      ).timeout(_timeout);

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['isFavorite'] ?? false;
      }
      throw _handleError(response);
    } catch (e) {
      throw Exception('Failed to toggle favorite: ${e.toString()}');
    }
  }

  String? _getAuthToken() {
    return _authCubit.state is AuthSuccess
        ? (_authCubit.state as AuthSuccess).user.token
        : null;
  }

  Map<String, String> _buildHeaders(String token) {
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  Exception _handleError(http.Response response) {
    if (response.statusCode == 401) {
      return Exception('Authentication required');
    } else if (response.statusCode == 404) {
      return Exception('Resource not found');
    } else {
      return Exception('Server error: ${response.statusCode}');
    }
  }
}