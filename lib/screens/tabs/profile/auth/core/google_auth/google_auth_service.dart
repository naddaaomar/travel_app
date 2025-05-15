import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final _googleSignIn = GoogleSignIn(
  scopes: ['email', 'profile'],
  clientId: '<907414361778-kdqh2h657inj03gp9rrkp74t86efqhbj.apps.googleusercontent.com>.apps.googleusercontent.com',
  hostedDomain: '',
  serverClientId: '<907414361778-kdqh2h657inj03gp9rrkp74t86efqhbj.apps.googleusercontent.com>.apps.googleusercontent.com', // For backend verification
);

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    clientId: '<YOUR_CLIENT_ID>',
  );

  static final _auth = FirebaseAuth.instance;
  static const String _backendAuthUrl = 'https://journeymate.runasp.net/api/Auth/googlelogin';

  static Future<GoogleSignInAccount?> login() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;

      final backendResponse = await _verifyWithBackend(
        idToken: googleAuth.idToken!,
        accessToken: googleAuth.accessToken!,
      );

      if (!backendResponse['success']) {
        throw Exception('Backend verification failed');
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      return googleUser;
    } catch (e) {
      print("Google Sign-In Error: $e");
      await logout();
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> _verifyWithBackend({
    required String idToken,
    required String accessToken,
  }) async {
    final response = await http.post(
      Uri.parse(_backendAuthUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'token': idToken,
        'flowName': 'GeneralOAuthFlow',
        'accessToken': accessToken,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Backend error: ${response.statusCode}');
    }
  }

  static Future<void> logout() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
