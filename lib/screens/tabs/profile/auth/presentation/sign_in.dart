import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/screens/tabs/profile/auth/core/cubit/auth_cubit.dart';
import 'package:p/screens/tabs/profile/auth/core/cubit/auth_state.dart';
import 'package:p/screens/tabs/profile/auth/presentation/sign_up.dart';
import 'package:p/screens/tabs/profile/auth/presentation/widgets/forget_password.dart';
import 'package:p/screens/tabs/profile/views/main_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/signin_controller.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _checkAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isSignedIn = await AppSignInController.isSignedIn();

    if (isSignedIn && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  MainProfile()),
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        final authCubit = context.read<AuthCubit>();
        await authCubit.signIn(
          username: _usernameController.text.trim(),
          password: _passwordController.text.trim(),

          context: context,
        );
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isSignedIn', true);
        await prefs.setString('name', _usernameController.text.trim());
        await prefs.setString('password', _passwordController.text.trim());

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
                      //height: MediaQuery.of(context).size.height,
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
                                    "Sign In",
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
                                    "Welcome Back!",
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
                              // height: double.infinity,
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
                                              duration: const Duration(
                                                  milliseconds: 1400),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                        color: Color.fromRGBO(
                                                            225, 95, 27, .3),
                                                        blurRadius: 20,
                                                        offset: Offset(0, 10)),
                                                  ],
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Container(
                                                      padding:
                                                      const EdgeInsets.all(
                                                          10),
                                                      decoration:
                                                      const BoxDecoration(
                                                        border: Border(
                                                          bottom: BorderSide(
                                                              color:
                                                              Colors.grey),
                                                        ),
                                                      ),
                                                      child: TextFormField(
                                                        controller:
                                                        _usernameController,
                                                        decoration:
                                                        const InputDecoration(
                                                            hintText:
                                                            "Username",
                                                            hintStyle: TextStyle(
                                                                fontFamily:
                                                                'vol',
                                                                color: Colors
                                                                    .grey),
                                                            border:
                                                            InputBorder
                                                                .none),
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return 'Please enter your email';
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                    ),
                                                    Container(
                                                      padding:
                                                      const EdgeInsets.all(
                                                          10),
                                                      child: TextFormField(
                                                        controller:
                                                        _passwordController,
                                                        obscureText: true,
                                                        decoration:
                                                        const InputDecoration(
                                                          hintText: "Password",
                                                          hintStyle: TextStyle(
                                                              fontFamily: 'vol',
                                                              color:
                                                              Colors.grey),
                                                          border:
                                                          InputBorder.none,
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
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 64,
                                            ),
                                            FadeInUp(
                                              duration: const Duration(
                                                  milliseconds: 1600),
                                              child: MaterialButton(
                                                onPressed: () async {
                                                  if (_formKey.currentState ==
                                                      null ||
                                                      !_formKey.currentState!
                                                          .validate()) {
                                                    return;
                                                  }

                                                  try {
                                                    final authCubit = context
                                                        .read<AuthCubit>();
                                                    if (authCubit == null) {
                                                      throw Exception(
                                                          'Authentication service not available');
                                                    }
                                                    await authCubit.signIn(
                                                      username: _usernameController
                                                          .text
                                                          .trim(),
                                                      password:
                                                      _passwordController
                                                          .text
                                                          .trim(),
                                                      context: context,
                                                    );
                                                    await _signIn();
                                                  } catch (e) {
                                                    ScaffoldMessenger.of(
                                                        context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                          content: Text(
                                                              e.toString())),
                                                    );
                                                  }
                                                },
                                                height: 50,
                                                color: const Color(0xFFB43E26),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(50),
                                                ),
                                                child: const Center(
                                                  child: Text(
                                                    "Sign In",
                                                    style: TextStyle(
                                                        fontFamily: 'vol',
                                                        color: Colors.white,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            FadeInUp(
                                              duration: const Duration(
                                                  milliseconds: 1500),
                                              child: TextButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ForgetPassword(),
                                                    ),
                                                  );
                                                },
                                                child: const Text(
                                                  "Forget Password?",
                                                  style: TextStyle(
                                                      fontFamily: 'vol',
                                                      color: Colors.grey),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 24,
                                            ),
                                            FadeInUp(
                                              duration: const Duration(
                                                  milliseconds: 1500),
                                              child: TextButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          SignUpPage(),
                                                    ),
                                                  );
                                                },
                                                child: const Text(
                                                  "Don’t have account? SIGN UP",
                                                  style: TextStyle(
                                                      fontFamily: 'vol',
                                                      color: Colors.grey),
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
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
