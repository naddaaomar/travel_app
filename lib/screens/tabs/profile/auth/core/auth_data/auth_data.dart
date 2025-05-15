import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:p/screens/tabs/profile/auth/core/auth_data/AuthDataModel.dart';

class AuthData {
  AuthData._();

  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://journeymate.runasp.net',
      validateStatus: (status) {
        return status! < 500; // Don't throw for 4xx errors
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
  static Future<String?> getRefreshToken() => _storage.read(key: 'refreshToken');

  static Future<void> clearTokens() async {
    await _storage.delete(key: 'token');
    await _storage.delete(key: 'refreshToken');
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

      if (response.statusCode == 200) {
        final authData = AuthDataModel.fromJson(response.data);
        await _saveTokens(authData);
        return authData;
      }
      return null;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  static Future<AuthDataModel?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/Authentication/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final authData = AuthDataModel.fromJson(response.data);
        await _saveTokens(authData);
        return authData;
      }
      return null;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  static Future<AuthDataModel?> refreshAccessToken() async {
    try {
      final refreshToken = await getRefreshToken();
      if (refreshToken == null) throw 'Refresh token not found';

      final response = await _dio.post(
        '/Authentication/refresh',
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200) {
        final authData = AuthDataModel.fromJson(response.data);
        await _saveTokens(authData);
        return authData;
      }
      return null;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  static Future<void> signOut() async {
    await clearTokens();
  }

  static Future<void> _saveTokens(AuthDataModel authData) async {
    if (authData.token != null) {
      await _storage.write(key: 'token', value: authData.token);
    }
    if (authData.refreshToken != null) {
      await _storage.write(key: 'refreshToken', value: authData.refreshToken);
    }
  }

  static String _handleError(DioException e) {
    if (e.response != null && e.response?.data is Map && e.response?.data['message'] != null) {
      return e.response?.data['message'];
    }
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
              final updated = await refreshAccessToken();
              if (updated?.token != null) {
                error.requestOptions.headers['Authorization'] = 'Bearer ${updated!.token}';
                final clone = await _dio.fetch(error.requestOptions);
                return handler.resolve(clone);
              }
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