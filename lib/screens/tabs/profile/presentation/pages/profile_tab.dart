import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/home/views/widgets/home_view_body.dart';
import 'package:p/screens/auth/core/cubit/auth_cubit.dart';
import 'package:p/screens/auth/core/cubit/auth_state.dart';
import 'package:p/screens/auth/presentation/pages/sign_in.dart';
import 'package:p/screens/auth/presentation/pages/sign_up.dart';
import 'package:p/screens/settings/bloc/theme_bloc/theme_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../auth/core/new_google_auth/g_auth_cubit.dart';
import '../../../../auth/core/new_google_auth/g_auth_state.dart';
import '../widgets/main_profile.dart';

class PersonTab extends StatefulWidget {
  final ValueNotifier<AppBarState> appBarStateNotifier;

  const PersonTab({
    Key? key,
    required this.appBarStateNotifier})
      : super(key: key);

  @override
  State<PersonTab> createState() => _PersonTabState();
}

class _PersonTabState extends State<PersonTab> {
  final GlobalKey<NavigatorState> _profileTabNavigatorKey = GlobalKey<NavigatorState>();
  final _secureStorage = const FlutterSecureStorage();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    widget.appBarStateNotifier.value = AppBarState.transparent;
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    try {
      final token = await _secureStorage.read(key: 'auth_token');
      final provider = await _secureStorage.read(key: 'auth_provider');

      if (token != null && mounted) {
        if (provider == 'google') {
          context.read<GoogleAuthCubit>().checkAuthStatus();
        } else {
          _profileTabNavigatorKey.currentState?.pushReplacementNamed('/mainProfile');
        }
      } else {
        final prefs = await SharedPreferences.getInstance();
        if (prefs.getBool('isSignedIn') == true && mounted) {
          _profileTabNavigatorKey.currentState?.pushReplacementNamed('/mainProfile');
        }
      }
    } catch (e) {
      debugPrint('Auth check error: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Center(
        child: CircularProgressIndicator());

    return MultiBlocListener(
      listeners: [
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) async {
            if (state is AuthSuccess) {
              await _secureStorage.write(key: 'auth_token', value: state.user.token!);
              await _secureStorage.write(key: 'auth_provider', value: 'email');
              _profileTabNavigatorKey.currentState?.pushReplacementNamed('/mainProfile');
            }
          },
        ),
        BlocListener<GoogleAuthCubit, GoogleAuthState>(
          listener: (context, state) {
            if (state is GoogleAuthAuthenticated) {
              _profileTabNavigatorKey.currentState?.pushReplacementNamed('/mainProfile');
            }
          },
        ),
      ],
      child: Navigator(
        key: _profileTabNavigatorKey,
        initialRoute: '/',
        observers: [ProfileTabNavigatorObserver(widget.appBarStateNotifier)],
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          final authState = context.read<AuthCubit>().state;
          final googleAuthState = context.read<GoogleAuthCubit>().state;

          bool isAuthenticated = authState is AuthSuccess ||
              googleAuthState is GoogleAuthAuthenticated;

          switch (settings.name) {
            case '/':
              builder = (context) => isAuthenticated
                  ? MainProfile()
                  : const _AuthOptionsScreen();
              break;
            case '/signIn':
              builder = (context) => const SignInPage();
              break;
            case '/signUp':
              builder = (context) => const SignUpPage();
              break;
            case '/mainProfile':
              builder = (context) => MainProfile();
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

class ProfileTabNavigatorObserver extends NavigatorObserver {
  final ValueNotifier<AppBarState> appBarStateNotifier;

  ProfileTabNavigatorObserver(this.appBarStateNotifier);

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _updateAppBarState(route.settings.name);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (previousRoute != null) {
      _updateAppBarState(previousRoute.settings.name);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute != null) {
      _updateAppBarState(newRoute.settings.name);
    }
  }

  void _updateAppBarState(String? routeName) {
    switch (routeName) {
      case '/':
        appBarStateNotifier.value = AppBarState.transparent;
        break;
      case '/signIn':
      case '/signUp':
        appBarStateNotifier.value = AppBarState.hidden;
        break;
      case '/mainProfile':
        appBarStateNotifier.value = AppBarState.color;
        break;
      default:
        appBarStateNotifier.value = AppBarState.transparent;
    }
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
                ),
              ),
              const SizedBox(height: 120),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/signIn');
                },
                child: Container(
                  height: 53,
                  width: 320,
                  decoration: BoxDecoration(
                    color: isLight
                        ? ColorApp.thirdColor
                        : ColorApp.primaryColorDark,
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
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/signUp');
                },
                child: Container(
                  height: 53,
                  width: 320,
                  decoration: BoxDecoration(
                    color: isLight
                        ? Colors.white
                        : ColorApp.secondaryColorDark,
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
                  ),
                ),
              ),
              const SizedBox(height: 6),
            BlocBuilder<GoogleAuthCubit, GoogleAuthState>(
            builder: (context, state) {
              if (state is GoogleAuthLoading) {
                return const CircularProgressIndicator();
              }
              return ElevatedButton(
                onPressed: () => context.read<GoogleAuthCubit>().signInWithGoogle(),
                child: Container(
                  decoration: BoxDecoration(
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
                      height: 30,
                      fit: BoxFit.fitHeight,
                    ),
                  ],
                ),
                ),
              );
            },
          ),

            /*GestureDetector(
                onTap: () async {
                  final user = await GoogleSignInService.signIn();
                  if (user != null && context.mounted) {
                    // Navigate to main profile on successful Google sign-in
                    Navigator.of(context).pushReplacementNamed('/mainProfile');
                  } else if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('signin_failed')),
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
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
               */

              const SizedBox(height: 140),
            ],
          ),
        ),
      ),
    );
  }
}
