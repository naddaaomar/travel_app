import 'package:bloc/bloc.dart';
import 'g_auth_repo.dart';
import 'g_auth_state.dart';

class GoogleAuthCubit extends Cubit<GoogleAuthState> {
  final GoogleAuthRepository _repository;

  GoogleAuthCubit(this._repository) : super(GoogleAuthInitial());

  Future<void> signInWithGoogle() async {
    emit(GoogleAuthLoading());
    try {
      final token = await _repository.signInWithGoogle();
      if (token != null) {
        emit(GoogleAuthAuthenticated(token: token));
      } else {
        emit(GoogleAuthUnauthenticated());
      }
    } catch (e) {
      emit(GoogleAuthError(message: e.toString()));
    }
  }

  Future<void> signOut() async {
    emit(GoogleAuthLoading());
    try {
      await _repository.signOut();
      emit(GoogleAuthUnauthenticated());
    } catch (e) {
      emit(GoogleAuthError(message: e.toString()));
    }
  }

  Future<void> checkAuthStatus() async {
    emit(GoogleAuthLoading());
    try {
      final isSignedIn = await _repository.isSignedIn();
      if (isSignedIn) {
        final token = await _repository.getCurrentToken();
        if (token != null) {
          emit(GoogleAuthAuthenticated(token: token));
        } else {
          emit(GoogleAuthUnauthenticated());
        }
      } else {
        emit(GoogleAuthUnauthenticated());
      }
    } catch (e) {
      emit(GoogleAuthError(message: e.toString()));
    }
  }
}