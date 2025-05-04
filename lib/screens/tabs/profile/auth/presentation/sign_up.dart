import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:p/screens/tabs/profile/pages/main_profile.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailPhoneController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        key: _formKey,
        child: Stack(children: [
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FadeInUp(
                          duration: const Duration(milliseconds: 1000),
                          child: const Text(
                            "Create Your Account",
                            style: TextStyle(
                                fontFamily: 'vol',
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        FadeInUp(
                          duration: const Duration(milliseconds: 1300),
                          child: const Text(
                            "Welcome!",
                            style: TextStyle(
                                fontFamily: 'vol',
                                color: Colors.white,
                                fontSize: 20),
                          ),
                        ),
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
                              topRight: Radius.circular(60))),
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return SingleChildScrollView(
                              physics: const ClampingScrollPhysics(),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: constraints.maxHeight,
                                ),
                                child: Column(
                                  children: <Widget>[
                                    const SizedBox(
                                      height: 60,
                                    ),
                                    FadeInUp(
                                      duration:
                                      const Duration(milliseconds: 1400),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Color.fromRGBO(225, 95, 27, .3),
                                                blurRadius: 20,
                                                offset: Offset(0, 10)),],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              padding:
                                              const EdgeInsets.all(10),
                                              decoration:
                                              const BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors.grey),
                                                ),
                                              ),
                                              child: TextFormField(
                                                controller: _nameController,
                                                decoration: const InputDecoration(
                                                    hintText: "Name",
                                                    hintStyle: TextStyle(
                                                        fontFamily: 'vol',
                                                        color: Colors.grey),
                                                    border:
                                                    InputBorder.none),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter your name';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            Container(
                                              padding:
                                              const EdgeInsets.all(10),
                                              decoration:
                                              const BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors.grey),
                                                ),
                                              ),
                                              child: TextFormField(
                                                controller:
                                                _emailPhoneController,
                                                decoration: const InputDecoration(
                                                    hintText:
                                                    "Email or Phone number",
                                                    hintStyle: TextStyle(
                                                        fontFamily: 'vol',
                                                        color: Colors.grey),
                                                    border:
                                                    InputBorder.none),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter your email or phone number';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            Container(
                                              padding:
                                              const EdgeInsets.all(10),
                                              decoration:
                                              const BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors.grey),
                                                ),
                                              ),
                                              child: TextFormField(
                                                controller:
                                                _passwordController,
                                                obscureText: !_passwordVisible,
                                                decoration: InputDecoration(
                                                  hintText: "Password",
                                                  hintStyle: const TextStyle(
                                                      fontFamily: 'vol',
                                                      color: Colors.grey),
                                                  border:
                                                  InputBorder.none,
                                                  suffixIcon: IconButton(
                                                    icon: Icon(
                                                      _passwordVisible
                                                          ? Icons.visibility
                                                          : Icons
                                                          .visibility_off,
                                                      color: Colors.grey,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        _passwordVisible =
                                                        !_passwordVisible;
                                                      });
                                                    },
                                                  ),
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
                                            Container(
                                              padding:
                                              const EdgeInsets.all(10),
                                              child: TextFormField(
                                                controller:
                                                _rePasswordController,
                                                obscureText: !_passwordVisible,
                                                decoration: InputDecoration(
                                                  hintText: "Re-Password",
                                                  hintStyle: const TextStyle(
                                                      fontFamily: 'vol',
                                                      color: Colors.grey),
                                                  border:
                                                  InputBorder.none,
                                                  suffixIcon: IconButton(
                                                    icon: Icon(
                                                      _passwordVisible
                                                          ? Icons.visibility
                                                          : Icons
                                                          .visibility_off,
                                                      color: Colors.grey,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        _passwordVisible =
                                                        !_passwordVisible;
                                                      });
                                                    },
                                                  ),
                                                ),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please re-enter your password';
                                                  }
                                                  if (value !=
                                                      _passwordController.text) {
                                                    return 'Passwords do not match';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    FadeInUp(
                                      duration:
                                      const Duration(milliseconds: 1600),
                                      child: MaterialButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => MainProfile(),
                                              ),
                                            );
                                          }
                                        },
                                        height: 60,
                                        color: const Color(0xFFB43E26),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(50),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Sign Up",
                                            style: TextStyle(
                                                fontFamily: 'vol',
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

