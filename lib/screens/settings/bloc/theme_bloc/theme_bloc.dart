import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeMode> {
  ThemeBloc() : super(ThemeMode.light) {
    on<LoadTheme>(_onLoadTheme);
    on<ChangeTheme>(_onChangeTheme);

    add(LoadTheme());
  }

  Future<void> _onLoadTheme(LoadTheme event, Emitter<ThemeMode> emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDark = prefs.getBool("isdark") ?? false;
    emit(isDark ? ThemeMode.dark : ThemeMode.light);

    print("Loaded Theme: ${isDark ? 'Dark' : 'Light'}");  // Debugging print
  }

  Future<void> _onChangeTheme(ChangeTheme event, Emitter<ThemeMode> emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isdark', event.isDark);
    emit(event.isDark ? ThemeMode.dark : ThemeMode.light);

    print("Theme Changed: ${event.isDark ? 'Dark' : 'Light'}");  // Debugging print
  }

}