import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';


class GoogleSignInService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile', 'openid'],
    serverClientId: '907414361778-75oo6cb1lku9jojibe3fa3p4mj7h16nm.apps.googleusercontent.com',
  );

  static GoogleSignInAccount? get currentUser => _googleSignIn.currentUser;

  static void printWrapped(String text) {
    final pattern = RegExp('.{1,800}');
    pattern.allMatches(text).forEach((match) {
      debugPrint(match.group(0));
    });
  }

  static Future<Map<String, String>?> signIn() async {
    try {
      debugPrint("🔹 Showing Gmail Account Selection Popup");
      final user = await _googleSignIn.signIn();
      if (user != null) {
        final auth = await user.authentication;
        String? token = await user.authentication.then((auth) => auth.idToken);

        if (token == null || token.isEmpty) {
          throw Exception(
              "Google ID Token is null or empty. Possible reasons:\n"
                  "- Incorrect OAuth Client ID\n"
                  "- Missing SHA-1 key (debug/release)\n"
                  "- App not signed properly");
        }

        // Validate JWT format before sending
        if (!RegExp(r'^[A-Za-z0-9-_]+\.[A-Za-z0-9-_]+\.[A-Za-z0-9-_]+')
            .hasMatch(token)) {
          throw Exception("Invalid JWT format");
        }

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('id_token', token);
        String? name = user.displayName;
        String? email = user.email;
        String? photoUrl = user.photoUrl;


        await prefs.setString('user_name', name ?? "User");
        await prefs.setString('user_email', email);
        await prefs.setString('user_photo', photoUrl ?? "");

        printWrapped("Full ID Token: $token");
        debugPrint(" User Logged In:");
        debugPrint(" Email: ${user.email}");
        debugPrint(" Name: ${user.displayName}");
        debugPrint(" Profile Picture: ${user.photoUrl}");
        // globalPhotoUrl = user.photoUrl;
        // await prefs.setString('photo_url', globalPhotoUrl ?? '');
        return {
          'idToken': token,
          'accessToken': auth.accessToken ?? '',
          'email': user.email,
          'displayName': user.displayName ?? '',
          'photoUrl': user.photoUrl ?? '',
          'name': name ?? "User",
        };
      } else {
        throw Exception('User cancelled sign-in');
      }
    } on Exception catch (e) {
      debugPrint('Google sign-in error: ${e.toString()}');
      return Future.error('Google sign-in failed. Please try again.');
    } catch (error) {
      debugPrint('Error signing in with Google: $error');
      return Future.error(
          'An unknown error occurred during sign-in. Please try again.');
    }
  }

  static Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('id_token');
      await prefs.remove('user_name');
      await prefs.remove('user_email');
      await prefs.remove('user_photo');
      debugPrint('User signed out successfully.');
    } on Exception catch (e) {
      debugPrint('Google sign-out error: ${e.toString()}');
      return Future.error('Google sign-out failed. Please try again.');
    } catch (error) {
      debugPrint('Error signing out: $error');
      return Future.error(
          'An unknown error occurred during sign-out. Please try again.');
    }
  }

  static Future<void> signInSilently() async {
    try {
      await _googleSignIn.signInSilently();
    } on Exception catch (e) {
      debugPrint('Silent sign-in error: ${e.toString()}');
      return Future.error('Silent sign-in failed. Please try again.');
    } catch (error) {
      debugPrint('Error during silent sign-in: $error');
      return Future.error('An unknown error occurred during silent sign-in. Please try again.');
    }
  }

  static Future<bool> refreshToken() async {
    try {
      final user = await _googleSignIn.signInSilently();
      if (user != null) {
        final auth = await user.authentication;
        String? newIdToken = auth.idToken;
        String? newAccessToken = auth.accessToken;

        if (newIdToken != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('id_token', newIdToken);
          await prefs.setString('access_token', newAccessToken ?? '');
          return true;
        }
      }
      return false;
    } catch (error) {
      debugPrint('Error refreshing token: $error');
      return false;
    }
  }
}




































// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// final _googleSignIn = GoogleSignIn(
//   scopes: ['email', 'profile'],
//   clientId: '<907414361778-kdqh2h657inj03gp9rrkp74t86efqhbj.apps.googleusercontent.com>.apps.googleusercontent.com',
//   hostedDomain: '',
//   serverClientId: '<907414361778-kdqh2h657inj03gp9rrkp74t86efqhbj.apps.googleusercontent.com>.apps.googleusercontent.com', // For backend verification
// );

// class GoogleSignInApi {
//   static final _googleSignIn = GoogleSignIn(
//     scopes: ['email', 'profile'],
//     clientId: '<YOUR_CLIENT_ID>',
//   );

//   static final _auth = FirebaseAuth.instance;
//   static const String _backendAuthUrl = 'https://journeymate.runasp.net/api/Auth/googlelogin';

//   static Future<GoogleSignInAccount?> login() async {
//     try {
//       final googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) return null;

//       final googleAuth = await googleUser.authentication;

//       final backendResponse = await _verifyWithBackend(
//         idToken: googleAuth.idToken!,
//         accessToken: googleAuth.accessToken!,
//       );

//       if (!backendResponse['success']) {
//         throw Exception('Backend verification failed');
//       }

//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       await _auth.signInWithCredential(credential);
//       return googleUser;
//     } catch (e) {
//       print("Google Sign-In Error: $e");
//       await logout();
//       rethrow;
//     }
//   }

//   static Future<Map<String, dynamic>> _verifyWithBackend({
//     required String idToken,
//     required String accessToken,
//   }) async {
//     final response = await http.post(
//       Uri.parse(_backendAuthUrl),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'token': idToken,
//         'flowName': 'GeneralOAuthFlow',
//         'accessToken': accessToken,
//       }),
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Backend error: ${response.statusCode}');
//     }
//   }

//   static Future<void> logout() async {
//     await _googleSignIn.signOut();
//     await _auth.signOut();
//   }
// }
