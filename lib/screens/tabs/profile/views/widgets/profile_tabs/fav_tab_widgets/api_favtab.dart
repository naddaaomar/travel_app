import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:p/screens/tabs/profile/auth/core/cubit/auth_cubit.dart';
import 'package:p/screens/tabs/profile/auth/core/cubit/auth_state.dart';
import 'package:p/screens/tabs/profile/views/widgets/profile_tabs/fav_tab_widgets/modelllll.dart';

class ApiService {
  static const String baseUrl = 'https://journeymate.runasp.net';
  static const Duration timeout = Duration(seconds: 10);

  final AuthCubit authCubit;

  ApiService({required this.authCubit});

  Future<List<Trip>> getFavorites() async {
    try {
      final token = _getAuthToken();
      if (token == null) return [];

      final response = await http.get(
        Uri.parse('$baseUrl/api/Favorites'),
        headers: _buildHeaders(token),
      ).timeout(timeout);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        return data.map((item) {
          final trip = Trip.fromJson(item);
          trip.isFavorite = true;
          return trip;
        }).toList();
      } else {
        throw _handleErrorResponse(response);
      }
    } catch (e) {
      throw Exception('Failed to fetch favorites: ${e.toString()}');
    }
  }

  Future<bool> toggleFavorite(String tripId) async {
    try {
      final token = _getAuthToken();
      if (token == null) return false;

      final response = await http.post(
        Uri.parse('$baseUrl/api/Favorites/$tripId'),
        headers: _buildHeaders(token),
      ).timeout(timeout);

      if (response.statusCode == 200) {
        return true;
      } else {
        throw _handleErrorResponse(response);
      }
    } catch (e) {
      throw Exception('Failed to update favorite: ${e.toString()}');
    }
  }


  String? _getAuthToken() {
    return authCubit.state is AuthSuccess
        ? (authCubit.state as AuthSuccess).user.token
        : null;
  }

  Map<String, String> _buildHeaders(String token) {
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  Exception _handleErrorResponse(http.Response response) {
    if (response.statusCode == 401) {
      return Exception('Authentication required');
    } else if (response.statusCode == 404) {
      return Exception('Resource not found');
    } else {
      return Exception('Server error: ${response.statusCode}');
    }
  }
}