import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../api/api_constants.dart';

class ApiService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  // ==========================
  // GET API
  // ==========================
  static Future<http.Response> get(String endpoint) async {
    final token = await _storage.read(key: "token");

    return await http.get(
      Uri.parse("${ApiConstants.baseUrl}$endpoint"),
      headers: {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },
    );
  }

  // ==========================
  // POST API
  // ==========================
  static Future<http.Response> post(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    final token = await _storage.read(key: "token");

    print("API URL:");
    print("${ApiConstants.baseUrl}$endpoint");

    print("BODY:");
    print(body);

    try {
      final response = await http
          .post(
            Uri.parse("${ApiConstants.baseUrl}$endpoint"),

            headers: {
              "Content-Type": "application/json",
              if (token != null) "Authorization": "Bearer $token",
            },

            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 15));

      print("RESPONSE CODE:");
      print(response.statusCode);

      print("RESPONSE BODY:");
      print(response.body);

      return response;
    } on TimeoutException {
      throw Exception("Server timeout");
    } catch (e) {
      print("API ERROR:");
      print(e);

      throw Exception(e.toString());
    }
  }

  // ==========================
  // PUT API
  // ==========================
  static Future<http.Response> put(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    final token = await _storage.read(key: "token");

    return await http.put(
      Uri.parse("${ApiConstants.baseUrl}$endpoint"),
      headers: {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },
      body: jsonEncode(body),
    );
  }

  // ==========================
  // DELETE API
  // ==========================
  static Future<http.Response> delete(String endpoint) async {
    final token = await _storage.read(key: "token");

    return await http.delete(
      Uri.parse("${ApiConstants.baseUrl}$endpoint"),
      headers: {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },
    );
  }
}
