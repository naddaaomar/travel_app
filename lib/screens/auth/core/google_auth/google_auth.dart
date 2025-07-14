import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:p/screens/auth/core/auth_data/AuthDataModel.dart';

class GoogleAuth {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<AuthDataModel?> signIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      // Call your backend API with the Google token
      final apiResponse = await _callGoogleLoginApi(googleAuth.idToken);

      if (apiResponse != null && apiResponse['success'] == true) {
        // Use Firebase if still needed
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential =
        await _auth.signInWithCredential(credential);
        final User? user = userCredential.user;

        // if (user != null) {
        //   return AuthDataModel(
        //     userName: user.displayName,
        //     email: user.email,
        //     token: await user.getIdToken(),
        //     // Add any additional fields from your API response
        //   );
        // }
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Map<String, dynamic>?> _callGoogleLoginApi(String? idToken) async {
    if (idToken == null) return null;

    try {
      final response = await http.post(
        Uri.parse('https://journeymate.runasp.net/api/Auth/googlelogin'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'token': idToken}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to login with Google: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to call Google login API: $e');
    }
  }

  static Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}