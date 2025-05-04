import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'auth_state.dart';

/*
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);
  AuthData authData = AuthData();

  File? image;
  String? imageServer;


  registerCubit({
    required String password,
    required String gender,
    required String nationalId,
    required String phone,
    required String email,
    required String name,
    required BuildContext context,
  }) async {
    try {
      emit(AuthLoading());
      ProfileResponse authUser = await authData.register(
        context: context,
        password: password,
        gender: gender,
        nationalId: nationalId,
        phone: phone,
        email: email,
        name: name,
      );

      print("Register API Response: $authUser=========================");

      // Check if response is actually successful

      emit(AuthSuccess(user: authUser));
    } catch (e, stackTrace) {
      print("Exception occurred: $e");
      print(stackTrace);
      emit(AuthError(errorMessage: e.toString()));
    }
  }

  registerLogInCubit({
    required String password,
    required String email,
  }) async {
    try {
      emit(AuthLogInLoading());
      ProfileResponse authUser = await authData.registerSignIn(
        password: password,
        email: email,
      );

      print("Register API Response: $authUser=========================");

      // Check if response is actually successful

      emit(AuthLogInSuccess(user: authUser));
    } catch (e) {
      print("Exception occurred: $e");

      emit(AuthLogInError(errorMessage: e.toString()));
    }
  }
}
*/
