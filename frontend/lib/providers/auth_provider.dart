import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isLoggedIn = false;

  String? _error;

  bool get isLoading => _isLoading;

  bool get isLoggedIn => _isLoggedIn;

  String? get error => _error;

  // ==========================
  // Check Login
  // ==========================

  Future<void> checkLogin() async {
    _isLoggedIn = await AuthService.isLoggedIn();

    notifyListeners();
  }

  // ==========================
  // Register
  // ==========================

  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    _isLoading = true;

    _error = null;

    notifyListeners();

    try {
      final response = await AuthService.register(
        name: name,

        email: email,

        password: password,
      );

      print("REGISTER RESPONSE:");
      print(response);

      _isLoading = false;

      if (response["success"] == true) {
        notifyListeners();

        return true;
      }

      _error = response["message"];

      notifyListeners();

      return false;
    } catch (e) {
      _isLoading = false;

      _error = e.toString();

      notifyListeners();

      return false;
    }
  }

  // ==========================
  // LOGIN
  // ==========================

  Future<bool> login({required String email, required String password}) async {
    _isLoading = true;

    _error = null;

    notifyListeners();

    try {
      final response = await AuthService.login(
        email: email,

        password: password,
      );

      print("==========================");
      print("LOGIN RESPONSE");
      print(response);
      print("==========================");

      _isLoading = false;

      if (response["success"] == true) {
        _isLoggedIn = true;

        print("LOGIN SUCCESS");

        notifyListeners();

        return true;
      }

      _error = response["message"];

      notifyListeners();

      return false;
    } catch (e) {
      _isLoading = false;

      _error = e.toString();

      print("LOGIN ERROR : $e");

      notifyListeners();

      return false;
    }
  }

  // ==========================
  // Logout
  // ==========================

  Future<void> logout() async {
    await AuthService.logout();

    _isLoggedIn = false;

    notifyListeners();
  }
}
