import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/model/user_profile_model.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Future<void> loadProfile() async {
    emit(ProfileLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString('email') ?? 'no-email-set';

      final profile = UserProfile(
        name: prefs.getString('name') ?? 'No name',
        email: email,
        password: 'hidden',
      );

      print('CLEAN PROFILE EMAIL: ${profile.email}');
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError('Failed to load profile'));
    }
  }

  Future<void> updateName(String newName) async {
    if (state is! ProfileLoaded) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', newName);
      emit(ProfileLoaded((state as ProfileLoaded).profile.copyWith(name: newName)));
    } catch (e) {
      emit(ProfileError('Failed to update name'));
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', newName);
  }

  Future<void> updateEmail(String newEmail) async {
    if (state is! ProfileLoaded) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', newEmail);
      emit(ProfileLoaded((state as ProfileLoaded).profile.copyWith(email: newEmail)));
    } catch (e) {
      emit(ProfileError('Failed to update email'));
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', newEmail);
  }

  Future<bool> verifyPassword(String currentPassword) async {
    if (state is! ProfileLoaded) return false;

    try {
      final prefs = await SharedPreferences.getInstance();
      final storedPassword = prefs.getString('password') ??
          (state as ProfileLoaded).profile.password;
      return currentPassword == storedPassword;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updatePassword(String currentPassword, String newPassword) async {
    if (state is! ProfileLoaded) return false;

    try {
      if (!await verifyPassword(currentPassword)) {
        emit(ProfileError('Current password is incorrect'));
        return false;
      }
      if (newPassword.length < 6) {
        emit(ProfileError('Password must be at least 6 characters'));
        return false;
      }
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('password', newPassword);

      final updatedProfile = (state as ProfileLoaded).profile.copyWith(
        password: newPassword,
      );
      emit(ProfilePasswordUpdated(updatedProfile));

      return true;
    } catch (e) {
      emit(ProfileError('Failed to update password'));
      return false;
    }
  }
}