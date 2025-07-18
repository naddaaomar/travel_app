import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:p/screens/auth/core/auth_data/AuthDataModel.dart';
import 'package:p/screens/auth/core/auth_data/AuthDataModel.dart';
import 'package:p/screens/tabs/profile/profile_tabs/profile_tab_widgets/presentation/manager/profile_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth_data/auth_data.dart';
import 'auth_state.dart';
import '../auth_data/auth_data.dart';
import 'auth_state.dart';
import '../../../tabs/profile/profile_tabs/favorite_trips_widget/data/service/auth_check.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());


  Future<void> signIn({
    required String username,
    required String password,
    required BuildContext context,
  }) async {
    emit(AuthLoading());
    try {
      final user = await AuthData.signIn(
        username: username,
        password: password,
      );

      print(' Response from signIn: $user');
      print('Token: ${user?.token}');

      if (user?.token == null) {
        emit(AuthError(
            errorMessage: 'Authentication failed - no token received'));
        return;
      }

      final prefs = await SharedPreferences.getInstance();

      await prefs.setBool('isSignedIn', true);
      await prefs.setString('email', user!.email!);

      await prefs.setString('name', username);
      await prefs.setString('password', password);
      await prefs.setString('token', user.token!);

      final storedToken = prefs.getString('token');
      print("Token stored in SharedPreferences: $storedToken");

      print('CLEAN EMAIL SAVED: ${user.email}');

      if (context.mounted) {
        final profileCubit = context.read<ProfileCubit>();
        profileCubit.loadProfile();

        // profileCubit.loadProfile(username, user.email!, password);
      }

      await FavoriteAuth.saveAuthToken(user.token!);
      print("object///////////////////////////////////////");

      final payload = JwtDecoder.decode(user.token!);

      final userId = payload[
      "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier"];

      if (userId != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_id', userId);
      }

     // final storedToken = prefs.getString('token');
      print("Token stored in SharedPreferences: $storedToken");

      emit(AuthSuccess(user: user));
    } catch (e) {
      if (e is DioException) {
        print('Status Code: ${e.response?.statusCode}');
        print('Error Data: ${e.response?.data}');
        emit(AuthError(errorMessage: _parseDioError(e)));
      } else {
        print('Error: ${e.toString()}');
        emit(AuthError(errorMessage: 'Authentication failed: ${e.toString()}'));
      }
    }
  }


  Future<void> signUp({
    required String userName,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    emit(AuthLoading());
    try {
      final user = await AuthData.signUp(
        userName: userName,
        email: email,
        password: password,
      );

      print(' Response from signUp: $user');
      print('Token: ${user?.token}');

      if (user != null) {
        emit(AuthSuccess(user: user));

        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isSignedUp', true);
        await prefs.setString('email', email);
        await prefs.setString('name', userName);
        await prefs.setString('password', password);
        await prefs.setString('token', user.token!);
        final payload = JwtDecoder.decode(user.token!);

        final userId = payload[
        "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier"];

        if (userId != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('user_id', userId);
        }

        final storedToken = prefs.getString('token');
        print("Token stored in SharedPreferences: $storedToken");

        await FavoriteAuth.saveAuthToken(user.token!);
      } else {
        emit(AuthError(errorMessage: 'Registration failed'));
      }
    } catch (e) {
      if (e is DioException) {
        print('Status Code: ${e.response?.statusCode}');
        print('Error Data: ${e.response?.data}');
        emit(AuthError(errorMessage: _parseDioError(e)));
      } else {
        print('Error: ${e.toString()}');
        emit(AuthError(errorMessage: _cleanError(e)));
      }
    }
  }


  Future<void> signOut() async {
    await AuthData.signOut();
    emit(AuthInitial());
  }

  Future<void> checkAuthStatus() async {
    final token = await AuthData.getToken();
    if (token != null) {
      emit(AuthSuccess(user: AuthDataModel(token: token)));
    } else {
      emit(AuthInitial());
    }
  }

  String _cleanError(Object e) =>
      e.toString().replaceAll('Exception: ', '');

  String _parseDioError(DioException e) {
    if (e.response?.statusCode == 401) {
      return 'Invalid email or password';
    }
    if (e.response?.statusCode == 400) {
      return 'Bad request - please check your input';
    }
    if (e.response?.data is Map && e.response?.data['message'] != null) {
      return e.response!.data['message'];
    }
    return e.message ?? 'Network error occurred';
  }
}
