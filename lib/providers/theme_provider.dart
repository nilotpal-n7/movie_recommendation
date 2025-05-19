import 'package:flutter/material.dart';
import 'package:movie_recommendation/services/storage_service.dart';
import 'package:movie_recommendation/themes/dark_mode.dart';
import 'package:movie_recommendation/themes/light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkMode = false;
  ThemeData _themeData = lightMode;
  ThemeData get themeData => _themeData;

  ThemeProvider() {
    loadTheme();
  }

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    _themeData = isDarkMode ? darkMode : lightMode;
    StorageService.saveBool('isDarkMode', isDarkMode);
    notifyListeners();
  }

  Future<void> loadTheme() async {
    isDarkMode = await StorageService.loadBool('isDarkMode');
    _themeData = isDarkMode ? darkMode : lightMode;
    notifyListeners();
  }
}
