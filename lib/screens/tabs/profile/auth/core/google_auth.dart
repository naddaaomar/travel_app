import 'package:google_sign_in/google_sign_in.dart';

void googleSignIn() async {
  // Initialize GoogleSignIn with the scopes you want:
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
    ],
  );

  // Get the user after successful sign in
  var googleUser = await googleSignIn.signIn();
}
