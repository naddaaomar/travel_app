import 'package:flutter/material.dart';
import 'package:p/screens/profile/views/widgets/sign_in.dart';
import 'package:p/screens/profile/views/widgets/sign_up.dart';
import 'package:p/screens/profile/views/widgets/tab_bar.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:[
          ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              const TabBarPage(),
              const SizedBox(
                height: 30,
              ),

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
                  child: const Center(child: Text('SIGN IN',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),),),
                ),
              ),
              const SizedBox(height: 24,),
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
                child: Text('Login with Social Media',
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.white
                  ),),
              ),//
              const SizedBox(height: 12,),
            ],
          )
        ],
      ),
    );
  }
}