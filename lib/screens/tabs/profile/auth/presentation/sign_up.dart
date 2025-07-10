import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/screens/tabs/profile/auth/core/cubit/auth_cubit.dart';
import 'package:p/screens/tabs/profile/auth/core/cubit/auth_state.dart';
import 'package:p/screens/tabs/profile/auth/core/signin_controller.dart';
import 'package:p/screens/tabs/profile/views/widgets/main_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }

  Future<void> _checkAuthStatus() async {
    final isSignedIn = await AppSignInController.isSignedIn();
    if (isSignedIn && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainProfile()),
      );
    }
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        final authCubit = context.read<AuthCubit>();

        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();

        await authCubit.signUp(
          userName: _nameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          context: context,
        );

        await prefs.setBool('isSignedIn', true);
        await prefs.setString('email', _emailController.text.trim());
        await prefs.setString('name', _nameController.text.trim());
        await prefs.setString('password', _passwordController.text.trim());

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainProfile()),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MainProfile(),
                ),
              );
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Form(
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
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: IconButton(
                            icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        const SizedBox(
                          height: 60,
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
                        const SizedBox(height: 16),
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(60),
                                    topRight: Radius.circular(60)),
                            ),
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
                                            height: 40,
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
                                                          hintText: "Username",
                                                          hintStyle: TextStyle(
                                                              fontFamily: 'vol',
                                                              color: Colors.grey),
                                                          border:
                                                          InputBorder.none),
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Please enter your username';
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
                                                      _emailController,
                                                      decoration: const InputDecoration(
                                                          hintText:
                                                          "Email ",
                                                          hintStyle: TextStyle(
                                                              fontFamily: 'vol',
                                                              color: Colors.grey),
                                                          border:
                                                          InputBorder.none),
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Please enter your email ';
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
                                              onPressed: () async {
                                                if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
                                                  return;
                                                }

                                                try {
                                                  final authCubit = context.read<AuthCubit>();
                                                  if (authCubit == null) {
                                                    throw Exception('Authentication service not available');
                                                  }
                                                  await authCubit.signUp(
                                                    email: _emailController.text.trim(),
                                                    password: _passwordController.text.trim(),
                                                    userName: _nameController.text.trim(),
                                                    context: context,
                                                  );
                                                 await _signUp();
                                                } catch (e) {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(content: Text(e.toString())),
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

                                          /* onPressed: () {
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
                                    ),*/
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
            );
          },),
      ),
    );
  }
}

