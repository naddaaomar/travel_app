import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/helpers/themes/colors.dart';

class AppBarColorCubit extends Cubit<Color> {
  AppBarColorCubit() : super(Colors.transparent);

  void setPrimary() => emit( ColorApp.primaryColor );
  void setTransparent() => emit(Colors.transparent);
}



