import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://journeymate.runasp.net';
  static const Duration timeoutDuration = Duration(seconds: 30);

  // Forgot Password
  static Future<void> forgotPassword(String email) async {
    try {
      final response = await http
          .post(
        Uri.parse('$baseUrl/api/Auth/forgotpassword'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      )
          .timeout(timeoutDuration);

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result != true) {
          throw Exception('Reset request failed: Server responded with false');
        }
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['title'] ??
            'Error ${response.statusCode}: Failed to send reset email');
      }
    } on http.ClientException catch (e) {
      print('ClientException: ${e.message}');
      throw Exception('Network error: ${e.message}');
    } on TimeoutException catch (_) {
      print('TimeoutException: Request timed out');
      throw Exception('Request timed out. Please try again.');
    } catch (e) {
      print('Unknown error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  // Reset Password
  static Future<void> resetPassword({
    required String email,
    required String token,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final response = await http
          .post(
        Uri.parse('$baseUrl/api/Auth/resetpassword'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'token': token,
          'newPassword': newPassword,
          'confirmPassword': confirmPassword,
        }),
      )
          .timeout(timeoutDuration);
      print('Token sent to server: $token');
      print('Reset Password - Status Code: ${response.statusCode}');
      print('Reset Password - Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result != true) {
          throw Exception('Reset failed: Server responded with false');
        }
      } else {
        final errorData = jsonDecode(response.body);
        if (errorData['errors'] != null && errorData['errors'] is List) {
          final errors = (errorData['errors'] as List).join('\n');
          throw Exception(errors);
        }
        throw Exception(errorData['title'] ??
            'Error ${response.statusCode}: Failed to reset password');
      }
    } on http.ClientException catch (e) {
      print('ClientException: ${e.message}');
      throw Exception('Network error: ${e.message}');
    } on TimeoutException catch (_) {
      print('TimeoutException: Request timed out');
      throw Exception('Request timed out. Please try again.');
    } catch (e) {
      print('Unknown error: $e');
      throw Exception('An unexpected error occurred');
    }
  }
}
