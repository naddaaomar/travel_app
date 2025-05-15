import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:p/screens/tabs/profile/auth/presentation/sign_in.dart';
import 'package:p/screens/tabs/profile/auth/presentation/sign_up.dart';
import 'package:p/screens/tabs/profile/views/widgets/profile_tabs/profile.dart';
import '../../../../settings/bloc/theme_bloc/theme_bloc.dart';

class PersonTab extends StatelessWidget {
  const PersonTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeBloc>().state == ThemeMode.light;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top:80),
        child: Container(
          height: double.infinity,
          width: double.infinity,

          child: Column(
              children: [
                Text('Get Started ',
                  style: TextStyle(
                      fontFamily: "vol",
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      color: isLight ? Colors.black : Colors.white),
                ),
                SizedBox(height: 100,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignInPage()));
                },
                  child: Container(
                    height: 53,
                    width: 320,
                    decoration: BoxDecoration(
                      color: const Color(0xFFB43E26),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white),
                  ),
                  child: const Center(
                    child: Text('SIGN IN',
                    style: TextStyle(
                      fontFamily: 'vol',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                     ),),
                  ),
                ),
              ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SignUpPage()));
              },
              child: Container(
                height: 53,
                width: 320,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white),
                ),
                child: const Center(
                  child: Text('SIGN UP',
                    style: TextStyle(
                        fontFamily: 'vol',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),),),
              ),
            ),

                Spacer(),
                Center(
                  child: Text('Or Login With ',
                    style: TextStyle(
                        fontFamily: "vol",
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: isLight ? Colors.black : Colors.white),),
                ),
          SizedBox(height: 6,),
          GestureDetector(
            onTap: () async {
              try {
                final user = await GoogleSignInApi.login();
                if (user != null) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                        name: user.displayName ?? '',
                        email: user.email ?? '',
                        password: '',
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Google sign in was canceled'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              } catch (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Error signing in: $error"),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),

              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    'assets/images/google_PNG.png',
                    height: 24.0,
                    fit: BoxFit.fitHeight,
                  ),
                ],
              ),
            ),
          ),

                const SizedBox(height: 140,),
          ]),
        ),
      ),
    );
  }
}

Future signIn() async {
  await GoogleSignInApi.login();
}

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn();
  static Future<GoogleSignInAccount?> login()=> GoogleSignIn().signIn();
}
