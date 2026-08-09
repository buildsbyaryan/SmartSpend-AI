import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDark = true;

  bool get isDark => _isDark;

  ThemeMode get themeMode => _isDark ? ThemeMode.dark : ThemeMode.light;

  ThemeProvider() {
    loadTheme();
  }

  Future<void> toggleTheme(bool value) async {
    _isDark = value;

    notifyListeners();

    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool("dark_mode", value);
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    _isDark = prefs.getBool("dark_mode") ?? true;

    notifyListeners();
  }
}
