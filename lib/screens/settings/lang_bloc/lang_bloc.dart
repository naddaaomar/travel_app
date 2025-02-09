import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:equatable/equatable.dart';

part 'lang_event.dart';
part 'lang_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, Locale> {
  LocaleBloc() : super(const Locale('en')) {
    on<LoadLocale>(_onLoadLocale);
    on<ChangeLocale>(_onChangeLocale);

    add(LoadLocale()); // Load saved language on start
  }

  Future<void> _onLoadLocale(LoadLocale event, Emitter<Locale> emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLang = prefs.getString("lang");
    emit(savedLang == "ar" ? const Locale("ar") : const Locale("en"));

    print("${savedLang}===================");
  }

  Future<void> _onChangeLocale(ChangeLocale event, Emitter<Locale> emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("lang", event.locale.languageCode);
    emit(event.locale); // Just emit the new locale, no need to deal with EasyLocalization here
    print("${event.locale}====================================");
  }

}
