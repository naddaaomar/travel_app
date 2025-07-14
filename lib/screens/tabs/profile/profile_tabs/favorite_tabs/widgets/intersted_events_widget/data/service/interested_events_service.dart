import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../model/interseted_event_model.dart';

class InterestedEventsException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic error;

  const InterestedEventsException(this.message, [this.statusCode, this.error]);

  @override
  String toString() => 'InterestedEventsException: $message'
      '${statusCode != null ? ' (Status: $statusCode)' : ''}'
      '${error != null ? '\nError: $error' : ''}';
}

class InterestedEventsService {
  static const String _baseUrl = 'https://journeymate.runasp.net';
  static const String _apiPath = '/api/Event';           //NEEDED

  static const Duration _requestTimeout = Duration(seconds: 15);
  static const _storage = FlutterSecureStorage();

  final http.Client _client;

  InterestedEventsService({required http.Client client}) : _client = client;

  Future<List<InterstedEvents>> getInterestedEvents() async {
    try {
      final token = await _getAuthToken();
      final response = await _client.get(
        Uri.parse('$_baseUrl$_apiPath/interested'),
        headers: _headersWithAuth(token),
      ).timeout(_requestTimeout);

      return _parseResponse(
        response,
        parseSuccess: (json) => List<InterstedEvents>.from(
          json.map((x) => InterstedEvents.fromJson(x)),
        ),
      );
    } on http.ClientException catch (e) {
      throw InterestedEventsException('Network error', null, e.message);
    } catch (e) {
      throw InterestedEventsException(
        'Failed to fetch interested events',
        null,
        e.toString(),
      );
    }
  }

  Future<bool> toggleInterest(String eventId) async {
    ArgumentError.checkNotNull(eventId, 'eventId');

    try {
      final token = await _getAuthToken();
      final response = await _client.post(
        Uri.parse('$_baseUrl$_apiPath/toggle-interest/$eventId'),
        headers: _headersWithAuth(token),
      ).timeout(_requestTimeout);

      return _parseResponse<bool>(response, parseSuccess: (_) => true);
    } catch (e) {
      throw InterestedEventsException(
        'Failed to toggle interest for event $eventId',
        null,
        e.toString(),
      );
    }
  }

  Future<bool> clearAllInterests() async {
    try {
      final token = await _getAuthToken();
      final response = await _client.delete(
        Uri.parse('$_baseUrl$_apiPath/interested'),
        headers: _headersWithAuth(token),
      ).timeout(_requestTimeout);

      return _parseResponse<bool>(response, parseSuccess: (_) => true);
    } catch (e) {
      throw InterestedEventsException(
        'Failed to clear all interests',
        null,
        e.toString(),
      );
    }
  }

  Future<String> _getAuthToken() async {
    final token = await _storage.read(key: 'auth_token');
    if (token == null) {
      throw InterestedEventsException('Authentication required', 401);
    }
    return token;
  }

  Map<String, String> _headersWithAuth(String token) => {
    ..._baseHeaders,
    'Authorization': 'Bearer $token',
  };

  static const _baseHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  T _parseResponse<T>(
      http.Response response, {
        required T Function(dynamic json) parseSuccess,
      }) {
    final statusCode = response.statusCode;
    final body = response.body;

    try {
      final json = body.isNotEmpty ? jsonDecode(body) : null;

      if (statusCode >= 200 && statusCode < 300) {
        return parseSuccess(json);
      } else if (statusCode == 401) {
        throw InterestedEventsException(
          'Authentication expired or invalid',
          statusCode,
          json?['message'],
        );
      } else {
        final errorMessage = _extractErrorMessage(json, statusCode);
        throw InterestedEventsException(errorMessage, statusCode, json);
      }
    } on FormatException {
      throw InterestedEventsException(
        'Invalid response format',
        statusCode,
        body,
      );
    }
  }

  String _extractErrorMessage(dynamic json, int statusCode) {
    if (json is Map) {
      return json['title'] ??
          json['message'] ??
          json['error'] ??
          'Request failed with status $statusCode';
    }
    return 'Request failed with status $statusCode';
  }
}