import 'package:flutter/material.dart';
import 'package:myapp/util/sharepref.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = ThemeData.light();
  bool _isDarkMode = false;

  ThemeProvider() {
    _loadTheme(); // Load theme preference on initialization
  }

  ThemeData get themeData => _themeData;
  bool get isDarkMode => _isDarkMode;

  void _loadTheme() async {
    _isDarkMode = await getSharedPreferencesBool('darkMode');
    _themeData = _isDarkMode ? ThemeData.dark() : ThemeData.light();
    notifyListeners();
  }

  void toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    _themeData = _isDarkMode ? ThemeData.dark() : ThemeData.light();
    await setSharedPreferencesBool('darkMode', _isDarkMode);
    notifyListeners();
  }
}