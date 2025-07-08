import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/screens/tabs/profile/auth/core/cubit/auth_cubit.dart';
import 'package:p/screens/tabs/profile/auth/core/cubit/auth_state.dart';
import 'package:p/screens/tabs/profile/auth/core/google_auth/google_auth_service.dart';
import 'package:p/screens/tabs/profile/auth/presentation/sign_in.dart';
import 'package:p/screens/tabs/profile/auth/presentation/sign_up.dart';
import 'package:p/screens/tabs/profile/views/main_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../settings/bloc/theme_bloc/theme_bloc.dart';

class PersonTab extends StatefulWidget {
  const PersonTab({Key? key}) : super(key: key);

  @override
  State<PersonTab> createState() => _PersonTabState();
}

class _PersonTabState extends State<PersonTab> {
  final GlobalKey<NavigatorState> _profileTabNavigatorKey = GlobalKey<NavigatorState>();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isSignedIn = prefs.getBool('isSignedIn') ?? false;
      final token = prefs.getString('token');

      if (isSignedIn && token != null && mounted) {
        final isValid = await _verifyToken(token);
        if (isValid) {
          _profileTabNavigatorKey.currentState?.pushReplacementNamed('/mainProfile');
        } else {
          await prefs.clear();
        }
      }
    } catch (e) {
      debugPrint('Auth initialization error: $e');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
  Future<bool> _verifyToken(String token) async {
    return true;
  }


  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
          child: CircularProgressIndicator());
    }
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          _profileTabNavigatorKey.currentState?.pushReplacementNamed('/mainProfile');
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Authentication Error: ${state.errorMessage}')),
          );
        }
      },
      child: Navigator(
        key: _profileTabNavigatorKey,
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          final authState = context.read<AuthCubit>().state;
          String? authToken;
          if (authState is AuthSuccess) {
            authToken = authState.user?.token;
          }

          switch (settings.name) {
            case '/':
              if (authState is AuthSuccess) {
                builder = (BuildContext context) => MainProfile();
              } else {
                builder = (BuildContext context) => const _AuthOptionsScreen();
              }
              break;
            case '/signIn':
              builder = (BuildContext context) => const SignInPage();
              break;
            case '/signUp':
              builder = (BuildContext context) => const SignUpPage();
              break;
            case '/mainProfile':
              builder = (BuildContext context) => MainProfile();
              break;
            default:
              throw Exception('Invalid route: ${settings.name}');
          }
          return MaterialPageRoute(builder: builder, settings: settings);
        },
      ),
    );
  }
}

class _AuthOptionsScreen extends StatelessWidget {
  const _AuthOptionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeBloc>().state == ThemeMode.light;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Text(
                'Get Started ',
                style: TextStyle(
                  fontFamily: "vol",
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  color: isLight ? Colors.black : Colors.white,
                ),
              ),
              const SizedBox(height: 100), // Spacing below "Get Started"
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/signIn');
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
                    child: Text(
                      'SIGN IN',
                      style: TextStyle(
                        fontFamily: 'vol',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/signUp');
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
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(
                        fontFamily: 'vol',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Center(
                child: Text(
                  'Or Login With ',
                  style: TextStyle(
                    fontFamily: "vol",
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: isLight ? Colors.black : Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: () async {
                  final user = await GoogleSignInService.signIn();
                  if (user != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainProfile(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('signin_failed')),
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
                        offset: const Offset(0, 3),
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
              const SizedBox(height: 140),
            ],
          ),
        ),
      ),
    );
  }
}