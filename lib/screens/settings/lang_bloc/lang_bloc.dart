import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:equatable/equatable.dart';

import '../../../main.dart';

part 'lang_event.dart';
part 'lang_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, Locale> {
  LocaleBloc() : super(const Locale('en')) {
    on<ChangeLocale>(_onChangeLocale);
  }

  Future<void> _onChangeLocale(ChangeLocale event, Emitter<Locale> emit) async {
    emit(event.locale);

    await EasyLocalization.of(navigatorKey.currentContext!)!
        .setLocale(event.locale);
  }
}
