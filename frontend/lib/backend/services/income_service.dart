import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smart_spend_ai/backend/storage/token_storage.dart';

import '../../api/api_constants.dart';
import '../../models/income_model.dart';

class IncomeService {
  // =========================
  // CREATE INCOME (POST)
  // =========================

  static Future<bool> addIncome(Income income) async {
    try {
      final token = await TokenStorage.getToken();

      final response = await http.post(
        Uri.parse("${ApiConstants.baseUrl}${ApiConstants.income}"),

        headers: {
          "Content-Type": "application/json",

          "Authorization": "Bearer $token",
        },

        body: jsonEncode(income.toJson()),
      );

      print("ADD INCOME STATUS : ${response.statusCode}");
      print("ADD INCOME BODY : ${response.body}");

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print("Add Income Error : $e");

      return false;
    }
  }

  // =========================
  // GET ALL INCOME
  // =========================

  static Future<List<Income>> getIncome() async {
    try {
      final token = await TokenStorage.getToken();

      final response = await http.get(
        Uri.parse("${ApiConstants.baseUrl}${ApiConstants.income}"),

        headers: {
          "Content-Type": "application/json",

          "Authorization": "Bearer $token",
        },
      );

      print("GET INCOME STATUS : ${response.statusCode}");
      print("GET INCOME BODY : ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return (data["incomes"] as List)
            .map((e) => Income.fromJson(e))
            .toList();
      }

      return [];
    } catch (e) {
      print("Get Income Error : $e");

      return [];
    }
  }

  // =========================
  // UPDATE INCOME (PUT)
  // =========================

  static Future<bool> updateIncome(String id, Income income) async {
    try {
      final token = await TokenStorage.getToken();

      final response = await http.put(
        Uri.parse("${ApiConstants.baseUrl}${ApiConstants.income}/$id"),

        headers: {
          "Content-Type": "application/json",

          "Authorization": "Bearer $token",
        },

        body: jsonEncode(income.toJson()),
      );

      print("UPDATE INCOME STATUS : ${response.statusCode}");
      print("UPDATE INCOME BODY : ${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      print("Update Income Error : $e");

      return false;
    }
  }

  // =========================
  // DELETE INCOME
  // =========================

  static Future<bool> deleteIncome(String id) async {
    try {
      final token = await TokenStorage.getToken();

      final response = await http.delete(
        Uri.parse("${ApiConstants.baseUrl}${ApiConstants.income}/$id"),

        headers: {
          "Content-Type": "application/json",

          "Authorization": "Bearer $token",
        },
      );

      print("DELETE INCOME STATUS : ${response.statusCode}");
      print("DELETE INCOME BODY : ${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      print("Delete Income Error : $e");

      return false;
    }
  }
}
