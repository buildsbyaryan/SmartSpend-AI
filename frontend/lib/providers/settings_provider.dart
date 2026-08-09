import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  bool _notification = true;
  String _currency = "₹ INR";

  bool get notification => _notification;
  String get currency => _currency;

  SettingsProvider() {
    loadSettings();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    _notification = prefs.getBool("notification") ?? true;
    _currency = prefs.getString("currency") ?? "₹ INR";

    notifyListeners();
  }

  Future<void> toggleNotification(bool value) async {
    _notification = value;

    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("notification", value);
  }

  Future<void> changeCurrency(String value) async {
    _currency = value;

    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("currency", value);
  }
}
