part of 'lang_bloc.dart';

abstract class LocaleEvent {

}


class ChangeLocale extends LocaleEvent {
  final Locale locale;
   ChangeLocale(this.locale);
}
