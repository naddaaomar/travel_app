import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/screens/tabs/profile/auth/core/auth_data/AuthDataModel.dart';
import 'package:p/screens/tabs/profile/auth/core/auth_data/auth_data.dart';
import 'package:p/screens/tabs/profile/auth/core/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final Dio _dio;

  AuthCubit({required Dio dio})
      : _dio = dio,
        super(AuthInitial());

  Future<void> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    emit(AuthLoading());
    try {
      final user = await AuthData.signIn(
          email: email,
          password: password);

      if (user?.token == null) {
        emit(AuthError(errorMessage: 'Authentication failed - no token received'));
        return;
      }

      emit(AuthSuccess(user: user!));
    } catch (e) {
      emit(AuthError(
          errorMessage: e is DioException
              ? _parseDioError(e)
              : 'Authentication failed: ${e.toString()}'
      ));
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
      if (user != null) {
        emit(AuthSuccess(user: user));
      } else {
        emit(AuthError(errorMessage: 'Registration failed'));
      }
    } catch (e) {
      emit(AuthError(errorMessage: _cleanError(e)));
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