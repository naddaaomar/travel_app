import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:p/screens/tabs/profile/pages/sign_in.dart';
import 'main_profile.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(
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
                            child: const Text("Create Your Account",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),),
                        const SizedBox(height: 7,),
                        FadeInUp(
                            duration: const Duration(milliseconds: 1300),
                            child: const Text("Welcome!",
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
                                                hintText: "Name",
                                                hintStyle: TextStyle(color: Colors.grey),
                                                border: InputBorder.none
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                          border: Border(bottom: BorderSide(color: Colors.grey.shade200),),
                                          ),
                                          child: const TextField(
                                            decoration: InputDecoration(
                                            hintText: "Email or Phone number",
                                            hintStyle: TextStyle(color: Colors.grey),
                                            border: InputBorder.none
                                        ),
                                      ),
                                    ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            border: Border(bottom: BorderSide(color: Colors.grey.shade200),),
                                          ),
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                                hintText: "Password",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                                border: InputBorder.none,
                                                suffixIcon: IconButton(
                                                  icon: Icon(
                                                  _passwordVisible
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                    color: Colors.grey,
                                                ),
                                                onPressed: () {
                                                  setState (() {
                                                    _passwordVisible = !_passwordVisible;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                          border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                                          ),
                                          child: TextFormField(
                                            obscureText: true,
                                            decoration: InputDecoration(

                                              hintText: "Re-Password",
                                              hintStyle: TextStyle(
                                                color: Colors.grey),
                                              border: InputBorder.none,
                                              suffixIcon:  IconButton(
                                                icon: Icon(
                                                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                                                  color: Colors.grey,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _passwordVisible = !_passwordVisible;
                                                  });
                                                  },),
                                            ),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Please enter your password';
                                              }
                                              // Add more password validation rules here if needed
                                              return null;
                                            },
                                          ),
                                        ),],),
                                        ),
                              ),
                                        SizedBox(height: 40,),
                                        FadeInUp(
                                            duration: const Duration(milliseconds: 1600),
                                            child: MaterialButton(
                                              onPressed: () {Navigator.push(context,
                                                MaterialPageRoute(builder: (context) => SignInPage ()),);
                                                },
                                              height: 50,
                                              color: const Color(0xFFB43E26),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(50),
                                              ),

                                              child: const Center(
                                                child: Text("Sign Up",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold),),
                                              ),
                                            )),
                                        const SizedBox(height: 50,),
                                ],
                              ),)
                        ),
                    ))] ),
                  ),
        ),]),
      ),
    );
  }
}


