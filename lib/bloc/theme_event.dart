part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {
  ThemeEvent();
}

class ThemeChangeTextToYellow extends ThemeEvent{
  ThemeChangeTextToYellow();
}
class ThemeChangeTextToBlack extends ThemeEvent{
  ThemeChangeTextToBlack();
}

class ThemeChangeTextFontArial extends ThemeEvent {
  ThemeChangeTextFontArial();
}

class ThemeChangeTextFontLarge extends ThemeEvent {
  ThemeChangeTextFontLarge();
}

class ThemeChangeTextFontSmall extends ThemeEvent {
  ThemeChangeTextFontSmall();
}

class ThemeChangeCardBackgroundBlue extends ThemeEvent {
  ThemeChangeCardBackgroundBlue();
}

class ThemeChangeCardBackgroundYellow extends ThemeEvent {
  ThemeChangeCardBackgroundYellow();
}
