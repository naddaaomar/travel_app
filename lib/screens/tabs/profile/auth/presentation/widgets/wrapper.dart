import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/helpers/api_manager/api_manager.dart';
import 'package:p/screens/tabs/profile/auth/core/cubit/auth_cubit.dart';
import 'package:p/screens/tabs/profile/auth/core/cubit/auth_state.dart';
import 'package:p/screens/tabs/profile/views/widgets/profile_tabs/profile.dart';
import '../../core/signin_check.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(dio: ApiManager.dio)..checkAuthStatus(),
    child: BlocBuilder<AuthCubit,AuthState>(
      builder: (context , state){
        if(state is AuthSuccess){
          return ProfileScreen(email: state.user.email ?? '', password:  state.user.password ?? '', name:  state.user.userName ?? '',);
        } else {
          return SignInPage();}
      },
     ),
    );
  }
}
