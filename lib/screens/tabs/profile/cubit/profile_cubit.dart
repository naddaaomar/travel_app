import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'profile_response.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  static ProfileCubit get(context)=>BlocProvider.of(context);
  ProfileCubit() : super(ProfileInitial());

  ProfileData profileData = ProfileData();
  getProfileCubit({required String token}) async {
    try {
      emit(ProfileLoading());
      ProfileResponse profileResponse =
      await profileData.getProfile(token: token);

      print(profileResponse.user?.name);
      print(profileResponse.user?.name);
      print(profileResponse.user?.name);
      print(profileResponse.user?.name);
      print(profileResponse.user?.name);
      emit(ProfileSuccess(profileResponse: profileResponse));
    } catch (e) {
      emit(ProfileError());
      print(e.toString());
    }
  }
}