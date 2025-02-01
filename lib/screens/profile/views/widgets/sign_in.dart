import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: <Color>[
                  Color(0xFFB43E26),
                  Color(0xFFDF6951),
                  Color(0xFFFF9682),
                ],
              ),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 80,),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FadeInUp(
                          duration: const Duration(milliseconds: 1000),
                          child: const Text("Sign In",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),),
                        const SizedBox(height: 7,),
                        FadeInUp(
                            duration: const Duration(milliseconds: 1300),
                            child: const Text("Welcome Back",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20),)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(60),
                              topRight: Radius.circular(60))
                      ),
                      height: double.infinity,
                      width: double.infinity,
                      child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: Column(
                              children: <Widget>[
                                const SizedBox(height: 60,),
                                FadeInUp(
                                    duration: const Duration(milliseconds: 1400),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Color.fromRGBO(225, 95, 27, .3),
                                              blurRadius: 20,
                                              offset: Offset(0, 10)
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              border: Border(bottom: BorderSide(color: Colors.grey.shade200),),
                                            ),
                                            child: const TextField(
                                              decoration: InputDecoration(
                                                  hintText: "Email",
                                                  hintStyle: TextStyle(color: Colors.grey),
                                                  border: InputBorder.none
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                                            ),
                                            child: const TextField(
                                              obscureText: true,
                                              decoration: InputDecoration(
                                                  hintText: "Password",
                                                  hintStyle: TextStyle(color: Colors.grey),
                                                  border: InputBorder.none
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                const SizedBox(height: 80,),
                                FadeInUp(
                                    duration: const Duration(milliseconds: 1500),
                                    child: const Text("Forgot Password?",
                                      style: TextStyle(
                                          color: Colors.grey),)),
                                const SizedBox(height: 18,),
                                FadeInUp(
                                    duration: const Duration(milliseconds: 1600), child: MaterialButton(
                                    onPressed: () {},
                                    height: 50,
                                    color: const Color(0xFFB43E26),
                                    shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),

                                    child: const Center(
                                    child: Text("Sign In",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),),
                                  ),
                                )),
                                const SizedBox(height: 50,),

                              ],
                            ),
                          )

                      ),
                    ),
                  ),
                ],
              ),
            ),
          )],
      ),
    );
  }
}