part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {
  ThemeEvent();
}

class ThemeChangeTextToYellow extends ThemeEvent{
  ThemeChangeTextToYellow();
}
