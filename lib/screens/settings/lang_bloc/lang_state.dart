part of 'lang_bloc.dart';

abstract class LocaleState extends Equatable {
  const LocaleState();
  @override
  List<Object> get props => [];
}

class LocaleUpdated extends LocaleState {
  final Locale locale;
  const LocaleUpdated(this.locale);

  @override
  List<Object> get props => [locale];
}
