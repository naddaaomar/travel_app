import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:p/screens/auth/core/auth_data/AuthDataModel.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthData {
  AuthData._();

  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://journeymate.runasp.net',
      validateStatus: (status) {
        return status! < 500;
      },
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );
  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  static const String baseUrl = 'https://journeymate.runasp.net';

  static Dio get dio => _dio;

  static Future<void> initialize() {
    _dio.options.baseUrl = baseUrl;
    initInterceptors();
    return Future.value();
  }

  static Future<String?> getToken() => _storage.read(key: 'token');
  static Future<String?> getRefreshToken() =>
      _storage.read(key: 'refreshToken');
  static Future<String?> getUsrId() => _storage.read(key: 'user_id');

  static Future<void> clearTokens() async {
    await _storage.delete(key: 'token');
    await _storage.delete(key: 'refreshToken');
    await _storage.delete(key: 'user_id');
  }

  static Future<AuthDataModel?> signUp({
    required String userName,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/api/Auth/register',
        data: {
          'userName': userName,
          'email': email,
          'password': password,
        },
      );
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ));

      if (response.statusCode == 200) {
        final authData = AuthDataModel.fromJson(response.data);
        print(authData);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', email);

        await _saveTokens(authData);
        return authData;
      }
      return null;
    } on DioException catch (e) {
      print(e);
      print(e);
      print(e);
      print(e);
      print(e);
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ));
      throw _handleError(e);

    }
  }

  static Future<AuthDataModel?> signIn({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/api/Auth/login',
        data: {
          'username': username,
          'password': password,
        },
      );

      debugPrint('Login Response: ${response.data}');

      if (response.statusCode == 200) {
        final token = response.data['token'];
        if (token == null) throw Exception('No token received');

        final email = await _extractEmail(response.data, username);

        final authData = AuthDataModel(
          token: token,
          email: email,
        );

        await _saveAuthData(authData);
        return authData;
      }
      throw Exception('Login failed: ${response.data['message'] ?? 'Unknown error'}');
    } on DioException catch (e) {
      debugPrint('Login Error: ${e.message}');
      throw Exception(_handleError(e));
    }
  }

  static Future<String> _extractEmail(Map<String, dynamic> data, String username) async {
    final email = data['email'] ?? data['userEmail'] ?? data['Email'];

    if (email == null) {
      try {
        final prefs = await SharedPreferences.getInstance();
        return prefs.getString('email') ?? username;
      } catch (e) {
        debugPrint('Error accessing SharedPreferences: $e');
        return username;
      }
    }

    return email;
  }

  static Future<void> _saveAuthData(AuthDataModel authData) async {
    if (authData.token != null) {
      await _storage.write(key: 'token', value: authData.token);
    }
    if (authData.email != null) {
      await _storage.write(key: 'email', value: authData.email);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', authData.email!);
    }
  }

  // static Future<AuthDataModel?> refreshAccessToken() async {
  //   try {
  //     final refreshToken = await getRefreshToken();
  //     if (refreshToken == null) throw 'Refresh token not found';

  //     final response = await _dio.post(
  //       '/Authentication/refresh',
  //       data: {'refreshToken': refreshToken},
  //     );

  //     if (response.statusCode == 200) {
  //       final authData = AuthDataModel.fromJson(response.data);
  //       await _saveTokens(authData);
  //       return authData;
  //     }
  //     return null;
  //   } on DioException catch (e) {
  //     throw _handleError(e);
  //   }
  // }

  static Future<void> signOut() async {
    await clearTokens();
  }

  static Future<void> _saveTokens(AuthDataModel authData) async {
    if (authData.token != null) {
      await _storage.write(key: 'token', value: authData.token);

      // Decode token and extract userId
      Map<String, dynamic> decodedToken = JwtDecoder.decode(authData.token!);
      final userId = decodedToken[
          "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier"];

      if (userId != null) {
        await _storage.write(key: 'user_id', value: userId);
      }
    }

    if (authData.email != null) {
      await _storage.write(key: 'user_email', value: authData.email);
    }

    if (authData.userName != null) {
      await _storage.write(key: 'user_name', value: authData.userName);
    }
  }

  static String _handleError(DioException e) {
    if (e.response != null &&
        e.response?.data is Map &&
        e.response?.data['message'] != null) {
      print(e.error);
      return e.response?.data['message'];
    }
    print(e.error);

    return e.message ?? 'Network error occurred';
  }

  static void initInterceptors() {
    _dio.interceptors.clear();
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          if (error.response?.statusCode == 401) {
            try {
              // final updated = await refreshAccessToken();
              // if (updated?.token != null) {
              //   error.requestOptions.headers['Authorization'] = 'Bearer ${updated!.token}';
              //   final clone = await _dio.fetch(error.requestOptions);
              //   return handler.resolve(clone);
              // }
            } catch (_) {
              await signOut();
              return handler.next(error);
            }
          }
          return handler.next(error);
        },
      ),
    );
  }
}
