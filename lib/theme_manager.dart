// lib/theme_manager.dart

import 'package:flutter/material.dart';

class ThemeManager extends ChangeNotifier {
  bool _isDarkMode = false;
  MaterialColor _accentColor = Colors.deepPurple;

  bool get isDarkMode => _isDarkMode;
  MaterialColor get accentColor => _accentColor;

  ThemeMode get currentTheme => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme(bool isDark) {
    _isDarkMode = isDark;
    notifyListeners();
  }

  void setAccentColor(MaterialColor color) {
    _accentColor = color;
    notifyListeners();
  }
}