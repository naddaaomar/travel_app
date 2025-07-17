import 'package:equatable/equatable.dart';

abstract class GoogleAuthState extends Equatable {
  const GoogleAuthState();

  @override
  List<Object> get props => [];
}

class GoogleAuthInitial extends GoogleAuthState {}

class GoogleAuthLoading extends GoogleAuthState {}

class GoogleAuthAuthenticated extends GoogleAuthState {
  final String token;
  final String? email;
  final String? name;

  const GoogleAuthAuthenticated({
    required this.token,
    this.email,
    this.name,
  });

  @override
  List<Object> get props => [token];
}

class GoogleAuthUnauthenticated extends GoogleAuthState {}

class GoogleAuthError extends GoogleAuthState {
  final String message;

  const GoogleAuthError({required this.message});

  @override
  List<Object> get props => [message];
}