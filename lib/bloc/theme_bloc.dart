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
    if(event is ThemeChangeTextToYellow){
      yield ThemeTextYellow();
    }else if(event is ThemeChangeTextToBlack){
      yield ThemeTextBlack();
    }else if(event is ThemeChangeTextFontArial){
      yield ThemeTextFontArial();
    }else if(event is ThemeChangeTextFontLarge){
      yield ThemeTextFontLarge();
    }else if(event is ThemeChangeTextFontSmall){
      yield ThemeTextFontSmall();
    }else if(event is ThemeChangeCardBackgroundBlue){
      yield ThemeCardBackgroundBlue();
    }else if(event is ThemeChangeCardBackgroundYellow){
      yield ThemeCardBackgroundYellow();
    }
  }

}
