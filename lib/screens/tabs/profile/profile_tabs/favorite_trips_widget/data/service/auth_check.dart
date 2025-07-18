import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:p/screens/auth/core/cubit/auth_cubit.dart';
import 'package:p/screens/auth/core/cubit/auth_state.dart';
import 'package:p/screens/auth/presentation/pages/sign_in.dart';

class FavoriteAuth {
  static const _storage = FlutterSecureStorage();
  static const _tokenKey = 'token';

  static Future<bool> checkAuth(BuildContext context) async {
    final authCubit = await context.read<AuthCubit>();

    if (authCubit.state is AuthLoading) {
      await authCubit.stream.firstWhere((state) => state is! AuthLoading);
    }

    final isAuthenticated =await  authCubit.state is AuthSuccess;

    if (isAuthenticated) {
      await _syncTokenIfMissing(context);
      return true;
    }

    final bool? didSignIn = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => const SignInPage()),
    );

    if (didSignIn == true) {
      await _syncTokenIfMissing(context);
    }

    return didSignIn ?? false;
  }



  static Future<String?> getAuthToken(BuildContext context) async {
    final authCubit = context.read<AuthCubit>();
    if (authCubit.state is AuthSuccess) {
      return await _storage.read(key: _tokenKey);
    }
    return null;
  }

  static Future<void> saveAuthToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  static Future<void> clearAuthToken() async {
    await _storage.delete(key: _tokenKey);
  }

  static void showAuthRequiredMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('You need to be signed in to add or manage favorites.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  static Future<void> _syncTokenIfMissing(BuildContext context) async {
    final existingToken = await _storage.read(key: _tokenKey);
    if (existingToken == null) {
      final authCubit = context.read<AuthCubit>();
      if (authCubit.state is AuthSuccess) {
        final token = (authCubit.state as AuthSuccess).user.token;
        if (token != null) {
          await saveAuthToken(token);
        }
      }
    }
  }
}
