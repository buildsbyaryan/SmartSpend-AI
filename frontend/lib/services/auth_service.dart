import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'api_service.dart';

class AuthService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  // ==========================
  // Register
  // ==========================
  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    print("=========== REGISTER API ===========");
    print("URL : /auth/register");
    print("Name : $name");
    print("Email : $email");

    final response = await ApiService.post("/auth/register", {
      "name": name,
      "email": email,
      "password": password,
    });

    print("Status Code : ${response.statusCode}");
    print("Response : ${response.body}");

    final data = jsonDecode(response.body);

    print("====================================");

    return data;
  }

  // ==========================
  // Login
  // ==========================
  // ==========================
  // Login
  // ==========================

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    print("========== LOGIN API ==========");
    print("Email : $email");
    print("Password : $password");

    final response = await ApiService.post("/auth/login", {
      "email": email,
      "password": password,
    });

    print("STATUS CODE : ${response.statusCode}");
    print("BODY : ${response.body}");

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data["success"] == true) {
      print("TOKEN SAVING...");

      await _storage.write(key: "token", value: data["token"]);

      print("TOKEN SAVED");
    }

    return data;
  }

  // ==========================
  // Get Token
  // ==========================
  static Future<String?> getToken() async {
    return await _storage.read(key: "token");
  }

  // ==========================
  // Check Login
  // ==========================
  static Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: "token");

    return token != null;
  }

  // ==========================
  // Logout
  // ==========================
  static Future<void> logout() async {
    await _storage.delete(key: "token");
  }
}
