import 'package:p/screens/tabs/profile/auth/core/auth_data/auth_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSignInController {
  static const String _isSignedInKey = 'appIsSignedIn';
  static const String _userEmailKey = 'userEmail';

  static Future<bool> isSignedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isSignedInKey) ?? false;
  }

  static Future<void> setSignedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isSignedInKey, value);
  }

  static Future<void> saveUserEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userEmailKey, email);
  }

  static Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userEmailKey);
  }

  static Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_isSignedInKey);
    await prefs.remove(_userEmailKey);
    await AuthData.clearTokens();
  }
}
