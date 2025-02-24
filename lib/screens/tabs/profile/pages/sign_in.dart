import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:p/screens/tabs/profile/pages/main_profile.dart';
import 'package:p/screens/tabs/profile/pages/sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../views/widgets/tabs/first.dart';
import 'forget_password.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text; // For display purposes only.

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email); // Store email for auto-login.

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileScreen(
            value: email,
            pass: password,
            name: '',),
        ),
      );
    }
  }

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
                            child: const Text("Welcome Back!",
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
                            child: Form(
                              key: _formKey,
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
                                                border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors.grey.shade200),),
                                              ),
                                              child: TextFormField(
                                                controller: _emailController,
                                                decoration: InputDecoration(
                                                    hintText: "Email",
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey),
                                                    border: InputBorder.none
                                                ),
                                                validator: (value){
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter your email';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors.grey.shade200))
                                              ),
                                              child: TextFormField(
                                                controller: _passwordController,
                                                obscureText: true,
                                                decoration: InputDecoration(
                                                    hintText: "Password",
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey),
                                                    border: InputBorder.none,
                                                ),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter your password';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                  const SizedBox(height: 80,),
                                  FadeInUp(
                                      duration: const Duration(milliseconds: 1600),
                                      child: MaterialButton(
                                       onPressed: () {
                                         if (_formKey.currentState!.validate()) {
                                           String email = _emailController.text;
                                           String password = _passwordController.text;
                                           print('Email: $email, Password: $password');
                                           Navigator.push(context, MaterialPageRoute(builder: (context) => MainProfile()));
                                         }
                                         },
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
                                  const SizedBox(height: 10,),
                                  FadeInUp(
                                      duration: const Duration(milliseconds: 1500),
                                      child: TextButton(
                                        onPressed: () {Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => ForgetPassword ()),);
                                        },
                                        child: Text("Forget Password?",
                                          style: TextStyle(
                                              color: Colors.grey
                                          ),),)),
                                  const SizedBox(height: 24,),
                                  FadeInUp(
                                      duration: const Duration(milliseconds: 1500),
                                      child: TextButton(
                                        onPressed: () {Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => SignUpPage ()),);
                                        },
                                        child: Text("Don’t have account? SIGN UP",
                                          style: TextStyle(
                                              color: Colors.grey
                                          ),),),),
                                  const SizedBox(height: 50,),
                                ],
                              ),
                            ),
                          ),
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
