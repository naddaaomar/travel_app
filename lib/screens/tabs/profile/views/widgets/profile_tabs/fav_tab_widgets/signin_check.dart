import 'package:flutter/material.dart';
import 'package:p/screens/tabs/profile/auth/presentation/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInController {
  static const String _authTokenKey = 'authToken';

  static Future<bool> isSignedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_authTokenKey) != null;
  }

  static Future<bool> handleAddToFavorites(
      BuildContext context,
      String tripId,
      VoidCallback onSuccess,
      ) async {
    final isSignedIn = await SignInController.isSignedIn();

    if (!isSignedIn) {
      final result = await Navigator.of(context).push<bool>(
        MaterialPageRoute(builder: (context) => SignInPage()),
      );

      if (result == true) {
        onSuccess();
        return true;
      }
      return false;
    } else {
      onSuccess();
      return true;
    }
  }
}

