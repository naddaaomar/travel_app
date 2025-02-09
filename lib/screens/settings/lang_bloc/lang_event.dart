part of 'lang_bloc.dart';

abstract class LocaleEvent extends Equatable {
  const LocaleEvent();
  @override
  List<Object> get props => [];
}

class LoadLocale extends LocaleEvent {}

class ChangeLocale extends LocaleEvent {
  final Locale locale;
  const ChangeLocale(this.locale);

  @override
  List<Object> get props => [locale];
}
