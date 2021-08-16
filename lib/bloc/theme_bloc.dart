import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {

  ThemeBloc() : super(ThemeInitial());

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if(event is ThemeChangeCardBackgroundToPurple){
      yield ThemeCardBackgroundPurple();
    }else if(event is ThemeChangeTitleFontToLarge){
      yield ThemeTitleFontLarge();
    }else if(event is ThemeChangeTitleFontToPurple){
      yield ThemeTitleFontPurple();
    }else if(event is ThemeChangeSynopsisFontToLarge){
      yield ThemeSynopsisFontLarge();
    }else if(event is ThemeChangeSynopsisFontToPurple){
      yield ThemeSynopsisFontPurple();
    }
  }

}
