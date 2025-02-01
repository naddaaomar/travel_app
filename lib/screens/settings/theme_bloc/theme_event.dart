part of 'theme_bloc.dart';


abstract class ThemeEvent {}


class ChangeTheme extends ThemeEvent {
  bool isDark;

  ChangeTheme(this.isDark);
}

