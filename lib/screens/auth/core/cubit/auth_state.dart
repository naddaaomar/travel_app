import 'package:meta/meta.dart';
import 'package:p/screens/auth/core/auth_data/AuthDataModel.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final AuthDataModel user;
  AuthSuccess({required this.user});
}

class AuthError extends AuthState {
  final String errorMessage;
  AuthError({required this.errorMessage});
}