import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/model/user_profile_model.dart';
import 'profile_state.dart';


class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Future<void> loadProfile(String defaultName, String defaultEmail,
      String defaultPassword) async {
    emit(ProfileLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final profile = UserProfile(
        name: prefs.getString('name') ?? defaultName,
        email: prefs.getString('email') ?? defaultEmail,
        password: prefs.getString('password') ?? defaultPassword,
      );
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError('Failed to load profile: $e'));
    }
  }

  Future<void> updateName(String newName) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', newName);
      if (state is ProfileLoaded) {
        final currentProfile = (state as ProfileLoaded).profile;
        emit(ProfileLoaded(currentProfile.copyWith(name: newName)));
      }
    } catch (e) {
      emit(ProfileError('Failed to update name: $e'));
    }
  }

  Future<void> updateEmail(String newEmail) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', newEmail);
      if (state is ProfileLoaded) {
        final currentProfile = (state as ProfileLoaded).profile;
        emit(ProfileLoaded(currentProfile.copyWith(email: newEmail)));
      }
    } catch (e) {
      emit(ProfileError('Failed to update email: $e'));
    }
  }

  Future<void> updatePassword(String currentPassword,
      String newPassword) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final storedPassword = prefs.getString('password') ?? '';

      if (currentPassword != storedPassword) {
        emit(ProfileError('Current password is incorrect'));
        return;
      }

      if (newPassword.length < 6) {
        emit(ProfileError('Password must be at least 6 characters'));
        return;
      }

      await prefs.setString('password', newPassword);
      if (state is ProfileLoaded || state is ProfilePasswordUpdated) {
        final currentProfile = (state is ProfileLoaded)
            ? (state as ProfileLoaded).profile
            : (state as ProfilePasswordUpdated).profile;
        emit(ProfileLoaded(currentProfile.copyWith(password: newPassword)));
      }
    } catch (e) {
      emit(ProfileError('Failed to update password: $e'));
    }
  }
}