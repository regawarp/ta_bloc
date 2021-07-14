part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {
  ThemeEvent();
}

class ThemeChangeTextToPurple extends ThemeEvent{
  ThemeChangeTextToPurple();
}
class ThemeChangeTextToBlack extends ThemeEvent{
  ThemeChangeTextToBlack();
}

class ThemeChangeTextFontArial extends ThemeEvent {
  ThemeChangeTextFontArial();
}
class ThemeChangeTextFontRoboto extends ThemeEvent {
  ThemeChangeTextFontRoboto();
}

class ThemeChangeTextFontLarge extends ThemeEvent {
  ThemeChangeTextFontLarge();
}

class ThemeChangeTextFontSmall extends ThemeEvent {
  ThemeChangeTextFontSmall();
}

class ThemeChangeCardBackgroundWhite extends ThemeEvent {
  ThemeChangeCardBackgroundWhite();
}

class ThemeChangeCardBackgroundPurple extends ThemeEvent {
  ThemeChangeCardBackgroundPurple();
}

class ThemeChangeImageSmall extends ThemeEvent{
  ThemeChangeImageSmall();
}

class ThemeChangeImageLarge extends ThemeEvent{
  ThemeChangeImageLarge();
}