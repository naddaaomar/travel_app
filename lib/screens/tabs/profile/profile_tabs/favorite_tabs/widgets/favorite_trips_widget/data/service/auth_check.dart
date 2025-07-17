import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/screens/auth/core/cubit/auth_cubit.dart';
import 'package:p/screens/auth/core/cubit/auth_state.dart';
import 'package:p/screens/auth/presentation/pages/sign_in.dart';

class FavoriteAuth {
  static Future<bool> checkAuth(BuildContext context) async {
    final authCubit = context.read<AuthCubit>();
    final isAuthenticated = authCubit.state is AuthSuccess;

    if (!isAuthenticated) {
      final result = await Navigator.of(context).push<bool>(
        MaterialPageRoute(builder: (context) => SignInPage()),
      );
      return result ?? false;
    }
    return true;
  }
}