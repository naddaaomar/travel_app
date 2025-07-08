//NOT USED
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenRefresh {
  final Dio dio;
  final FlutterSecureStorage storage;

  TokenRefresh({
    required this.dio,
    required this.storage,
  });

  Future<String?> call() async {
    try {
      final refreshToken = await storage.read(key: 'refreshToken');
      if (refreshToken == null) return null;

      final response = await dio.post(
        '\${AuthData.baseUrl}/Authentication/refresh',
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200 && response.data != null) {
        final newToken = response.data['token'] ?? response.data['accessToken'];
        final newRefresh = response.data['refreshToken'];

        if (newToken != null) {
          await storage.write(key: 'token', value: newToken);
          if (newRefresh != null) {
            await storage.write(key: 'refreshToken', value: newRefresh);
          }
          return newToken;
        }
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}
