part of 'theme_bloc.dart';

abstract class ThemeEvent {}

class LoadTheme extends ThemeEvent {}

class ChangeTheme extends ThemeEvent {
  final bool isDark;
  ChangeTheme(this.isDark);
}