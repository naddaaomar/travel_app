import 'package:flutter/material.dart';
import 'package:p/screens/tabs/profile/pages/sign_in.dart';
import 'package:p/screens/tabs/profile/pages/sign_up.dart';

class PersonTab extends StatelessWidget {
  const PersonTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 130),
        child: Container(
          height: double.infinity,
          width: double.infinity,

          child: Column(
              children: [
                Text('Welcome Back',
                  style: TextStyle(
                     color: Color(0xFFB43E26),
                     fontSize: 30,
                     fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 40,),
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
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                     ),),
                  ),
                ),
              ),
            SizedBox(height: 12,),
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
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),),),
              ),
            ),
                const Spacer(),
                const Center(
                  child: Text('Or Login With ',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black
                    ),),
                ),

                const SizedBox(height: 180,),
          ]),
        ),
      ),
    );
  }
}