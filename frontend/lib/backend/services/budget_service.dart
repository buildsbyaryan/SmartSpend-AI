import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../api/api_constants.dart';
import '../../models/budget_model.dart';
import '../storage/token_storage.dart';

class BudgetService {
  // ==================================
  // ADD BUDGET
  // ==================================

  static Future<bool> setBudget(Budget budget) async {
    try {
      final token = await TokenStorage.getToken();

      final response = await http.post(
        Uri.parse("${ApiConstants.baseUrl}/budgets"),

        headers: {
          "Content-Type": "application/json",

          "Authorization": "Bearer $token",
        },

        body: jsonEncode({
          "category": budget.category,

          "limit": budget.limit,

          "month": budget.month,

          "year": budget.year,
        }),
      );

      print("========== ADD BUDGET ==========");

      print(
        "REQUEST : ${{"category": budget.category, "limit": budget.limit, "month": budget.month, "year": budget.year}}",
      );

      print("STATUS : ${response.statusCode}");

      print("BODY : ${response.body}");

      print("==============================");

      return response.statusCode == 201;
    } catch (e) {
      print("Add Budget Error : $e");

      return false;
    }
  }

  // ==================================
  // GET ALL BUDGETS
  // ==================================

  static Future<Budget?> getBudget() async {
    try {
      final token = await TokenStorage.getToken();

      final response = await http.get(
        Uri.parse("${ApiConstants.baseUrl}/budgets"),

        headers: {"Authorization": "Bearer $token"},
      );

      print("========== GET BUDGET ==========");

      print("STATUS : ${response.statusCode}");

      print("BODY : ${response.body}");

      print("==============================");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data["budgets"] != null && data["budgets"].isNotEmpty) {
          return Budget.fromJson(data["budgets"][0]);
        }
      }

      return null;
    } catch (e) {
      print("Get Budget Error : $e");

      return null;
    }
  }

  // ==================================
  // GET SINGLE BUDGET
  // ==================================

  static Future<Budget?> getSingleBudget(String id) async {
    try {
      final token = await TokenStorage.getToken();

      final response = await http.get(
        Uri.parse("${ApiConstants.baseUrl}/budgets/$id"),

        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return Budget.fromJson(data["budget"]);
      }

      return null;
    } catch (e) {
      print("Single Budget Error : $e");

      return null;
    }
  }

  // ==================================
  // DELETE BUDGET
  // ==================================

  static Future<bool> deleteBudget(String id) async {
    try {
      final token = await TokenStorage.getToken();

      final response = await http.delete(
        Uri.parse("${ApiConstants.baseUrl}/budgets/$id"),

        headers: {"Authorization": "Bearer $token"},
      );

      print("DELETE STATUS : ${response.statusCode}");

      print("DELETE BODY : ${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      print("Delete Budget Error : $e");

      return false;
    }
  }

  // ==================================
  // UPDATE BUDGET
  // ==================================

  static Future<bool> updateBudget(String id, Budget budget) async {
    try {
      final token = await TokenStorage.getToken();

      final response = await http.put(
        Uri.parse("${ApiConstants.baseUrl}/budgets/$id"),

        headers: {
          "Content-Type": "application/json",

          "Authorization": "Bearer $token",
        },

        body: jsonEncode({
          "category": budget.category,

          "limit": budget.limit,

          "month": budget.month,

          "year": budget.year,
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      print("Update Budget Error : $e");

      return false;
    }
  }
}
