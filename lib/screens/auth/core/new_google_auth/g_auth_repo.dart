import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthRepository {
  final Dio _dio;
  final GoogleSignIn _googleSignIn;
  final FlutterSecureStorage _storage;

  GoogleAuthRepository({
    required Dio dio,
    required GoogleSignIn googleSignIn,
    required FlutterSecureStorage storage,
  })  : _dio = dio,
        _googleSignIn = googleSignIn,
        _storage = storage;

  Future<String?> signInWithGoogle() async {
    try {
      final account = await _googleSignIn.signIn();
      if (account == null) return null;

      final auth = await account.authentication;
      final response = await _dio.post(
        '/api/Auth/googlelogin',
        data: {
          'idToken': auth.idToken,
          'accessToken': auth.accessToken,
        },
      );

      final token = response.data['token'] as String?;
      if (token != null) {
        await _storage.write(key: 'auth_token', value: token);
        await _storage.write(key: 'auth_provider', value: 'google');
      }
      return token;
    } catch (e) {
      throw Exception('Google authentication failed: ${e.toString()}');
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _storage.delete(key: 'auth_token');
    await _storage.delete(key: 'auth_provider');
  }

  Future<bool> isSignedIn() async {
    final token = await _storage.read(key: 'auth_token');
    final provider = await _storage.read(key: 'auth_provider');
    return token != null && provider == 'google';
  }

  Future<String?> getCurrentToken() async {
    return await _storage.read(key: 'auth_token');
  }
}