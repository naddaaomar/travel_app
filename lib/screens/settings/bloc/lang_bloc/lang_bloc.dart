import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../main.dart';
part 'lang_event.dart';

class LocaleBloc extends Bloc<LocaleEvent, Locale> {
  LocaleBloc() : super(Locale('en')) {
    on<ChangeLocale>((event, emit) async {
      emit(event.locale);

      await EasyLocalization.of(navigatorKey.currentContext!)!
          .setLocale(event.locale);
    });
  }
}