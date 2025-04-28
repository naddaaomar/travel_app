import 'package:flutter/material.dart';
import 'package:p/screens/tabs/profile/auth/core/signin_check.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../views/widgets/profile_body.dart';

class AppSignInController {
  static const String _isSignedInKey = 'appIsSignedIn';

  static Future<bool> isSignedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isSignedInKey) ??
        false;
  }

  static Future<void> setSignedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isSignedInKey, value);
  }

  static Future<void> checkSignInAndNavigate(
      BuildContext context, {
        required WidgetBuilder onSignedIn,
        required WidgetBuilder onNotSignedIn,
      }) async {
    final isSignedInValue = await isSignedIn(); // Use the static method
    if (isSignedInValue) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: onSignedIn),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: onNotSignedIn),
      );
    }
  }
}


class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: AppSignInController.checkSignInAndNavigate(
        context,
        onSignedIn: (context) => const ProfileBody(),
        onNotSignedIn: (context) =>  SignInPage(),
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          return
            const SizedBox.shrink();
        }
      },
    );
  }
}
