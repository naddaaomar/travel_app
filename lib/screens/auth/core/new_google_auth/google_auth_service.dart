import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GoogleAuthService {
  final GoogleSignIn _googleSignIn;
  final FlutterSecureStorage _storage;

  GoogleAuthService({
    GoogleSignIn? googleSignIn,
    FlutterSecureStorage? storage,
  }) : _googleSignIn = googleSignIn ?? GoogleSignIn.standard(),
        _storage = storage ?? const FlutterSecureStorage();

  Future<GoogleSignInAccount?> signIn() async {
    try {
      final account = await _googleSignIn.signIn();
      if (account != null) {
        final auth = await account.authentication;
        await _storage.write(key: 'auth_token', value: auth.accessToken!);
        await _storage.write(key: 'auth_provider', value: 'google');
      }
      return account;
    } catch (e) {
      await _storage.delete(key: 'auth_token');
      await _storage.delete(key: 'auth_provider');
      rethrow;
    }
  }

  Future<GoogleSignInAuthentication?> getAuthTokens() async {
    try {
      final user = await _googleSignIn.signInSilently();
      if (user != null) {
        final auth = await user.authentication;
        await _storage.write(key: 'auth_token', value: auth.accessToken!);
        await _storage.write(key: 'auth_provider', value: 'google');
        return auth;
      }
      return null;
    } catch (e) {
      await _storage.delete(key: 'auth_token');
      await _storage.delete(key: 'auth_provider');
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _storage.delete(key: 'auth_token');
    await _storage.delete(key: 'auth_provider');
  }

  Future<bool> isSignedIn() async {
    try {
      return await _googleSignIn.isSignedIn();
    } catch (e) {
      return false;
    }
  }
}