part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {
  ThemeEvent();
}

class ThemeChangeCardBackgroundToPurple extends ThemeEvent {
  ThemeChangeCardBackgroundToPurple();
}

class ThemeChangeTitleFontToLarge extends ThemeEvent {
  ThemeChangeTitleFontToLarge();
}

class ThemeChangeTitleFontToPurple extends ThemeEvent {
  ThemeChangeTitleFontToPurple();
}

class ThemeChangeSynopsisFontToLarge extends ThemeEvent {
  ThemeChangeSynopsisFontToLarge();
}

class ThemeChangeSynopsisFontToPurple extends ThemeEvent {
  ThemeChangeSynopsisFontToPurple();
}