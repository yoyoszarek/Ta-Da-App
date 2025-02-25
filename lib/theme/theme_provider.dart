import 'package:flutter/material.dart';
import 'dark_mode.dart';
import 'light_mode.dart';

class ThemeProvider extends ChangeNotifier{
  //initally, lightmode
  ThemeData  _themeData = lightMode;

  //get current theme

  ThemeData get themeData => _themeData;

  //is current theme dark mode

  bool get isDarkMode => _themeData == darkMode;

  //set Theme
  set themeData(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }
  void toggleTheme(){
    if (_themeData == lightMode){
      themeData = darkMode;
    } else{
      themeData = lightMode;
    }
  }
}