import 'dart:convert';

import 'package:http/http.dart' as http;

import '../storage/token_storage.dart';

class ApiService {
  static Future<Map<String, dynamic>> post(
    String url,
    Map<String, dynamic> body,
  ) async {
    final response = await http.post(
      Uri.parse(url),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode(body),
    );

    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> get(String url) async {
    final token = await TokenStorage.getToken();

    final response = await http.get(
      Uri.parse(url),

      headers: {"Authorization": "Bearer $token"},
    );

    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> put(
    String url,
    Map<String, dynamic> body,
  ) async {
    final token = await TokenStorage.getToken();

    final response = await http.put(
      Uri.parse(url),

      headers: {
        "Content-Type": "application/json",

        "Authorization": "Bearer $token",
      },

      body: jsonEncode(body),
    );

    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> delete(String url) async {
    final token = await TokenStorage.getToken();

    final response = await http.delete(
      Uri.parse(url),

      headers: {"Authorization": "Bearer $token"},
    );

    return jsonDecode(response.body);
  }
}
