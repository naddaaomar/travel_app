import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:p/screens/settings/bloc/theme_bloc/theme_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../auth/presentation/pages/sign_in.dart';
import '../manager/main_profile_cubit.dart';
import 'profile_body.dart';
import 'profile_topbar.dart';

class MainProfile extends StatelessWidget {
  const MainProfile({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeBloc>().state == ThemeMode.light;

    return BlocProvider(
      create: (context) => MainProfileCubit(client: http.Client()),
      child: BlocBuilder<MainProfileCubit, MainProfileState>(
        builder: (context, state) {
          if (state is MainProfileInitial || state is MainProfileLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (state is MainProfileError) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    ElevatedButton(
                      onPressed: () => context.read<MainProfileCubit>().refreshAllData(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is MainProfileLoaded) {
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(value: state.profileCubit),
                BlocProvider.value(value: state.favoritesCubit),
                BlocProvider.value(value: state.tripsTabCubit),
              ],
              child: ProfileContent(),
            );
          }

          return const Scaffold(
            body: Center(
                child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}

class ProfileContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String?>>(
      future: _getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
                child: CircularProgressIndicator()),
          );
        }

        final userData = snapshot.data ?? {};
        if (userData['name'] == null || userData['email'] == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SignInPage()),
            );
          });
          return const Scaffold(
              body: Center(
                  child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          body: Stack(
            children: [
              const TopBar(),
              ProfileBody(
                token: userData['token'],
                name: userData['name']!,
                email: userData['email']!,
              ),
            ],
          ),
        );
      },
    );
  }

  Future<Map<String, String?>> _getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString('name'),
      'email': prefs.getString('email'),
      'token': prefs.getString('token'),
    };
  }
}