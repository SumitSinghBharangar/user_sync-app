
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system; // Default to system theme
  static const String _themeKey = 'theme_mode';

  ThemeProvider() {
    _loadTheme();
  }

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() async {
    if (_themeMode == ThemeMode.system) {
      _themeMode = ThemeMode.light;
    } else if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.system;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _themeKey,
      _themeMode == ThemeMode.system
          ? 'system'
          : _themeMode == ThemeMode.light
              ? 'light'
              : 'dark',
    );
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString(_themeKey);
    if (theme == 'light') {
      _themeMode = ThemeMode.light;
    } else if (theme == 'dark') {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.system; // Default to system if no preference
    }
    notifyListeners();
  }
}
