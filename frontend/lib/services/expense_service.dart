import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smart_spend_ai/backend/storage/token_storage.dart';

import '../api/api_constants.dart';
import '../models/expense_model.dart';

class ExpenseService {
  /// CREATE
  static Future<bool> addExpense(Expense expense) async {
    try {
      final token = await TokenStorage.getToken();

      final response = await http.post(
        Uri.parse("${ApiConstants.baseUrl}${ApiConstants.expenses}"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(expense.toJson()),
      );

      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print("Add Expense Error : $e");
      return false;
    }
  }

  /// READ ALL
  static Future<List<Expense>> getExpenses() async {
    try {
      final token = await TokenStorage.getToken();

      print("TOKEN: $token");

      final response = await http.get(
        Uri.parse("${ApiConstants.baseUrl}${ApiConstants.expenses}"),
        headers: {"Authorization": "Bearer $token"},
      );

      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        print("DATA: ${data["data"]}");

        final expenses = (data["data"] as List)
            .map((e) => Expense.fromJson(e))
            .toList();

        print("TOTAL EXPENSES: ${expenses.length}");

        return expenses;
      }

      return [];
    } catch (e, s) {
      print("ERROR: $e");
      print(s);
      return [];
    }
  }

  /// READ SINGLE
  static Future<Expense?> getExpenseById(String id) async {
    try {
      final token = await TokenStorage.getToken();

      final response = await http.get(
        Uri.parse("${ApiConstants.baseUrl}${ApiConstants.expenses}/$id"),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Expense.fromJson(data["data"]);
      }

      return null;
    } catch (e) {
      print("Get Expense Error : $e");
      return null;
    }
  }

  /// UPDATE
  static Future<bool> updateExpense(String id, Expense expense) async {
    try {
      final token = await TokenStorage.getToken();

      print("UPDATE ID : $id");
      print("BODY : ${expense.toJson()}");
      print("TOKEN : $token");

      final response = await http.put(
        Uri.parse("${ApiConstants.baseUrl}${ApiConstants.expenses}/$id"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(expense.toJson()),
      );

      print("UPDATE STATUS : ${response.statusCode}");
      print("UPDATE RESPONSE : ${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      print("Update Expense Error : $e");
      return false;
    }
  }

  /// DELETE
  static Future<bool> deleteExpense(String id) async {
    try {
      final token = await TokenStorage.getToken();

      print("DELETE ID : $id");
      print("TOKEN : $token");

      final response = await http.delete(
        Uri.parse("${ApiConstants.baseUrl}${ApiConstants.expenses}/$id"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      print("DELETE STATUS : ${response.statusCode}");
      print("DELETE BODY : ${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      print("Delete Expense Error : $e");
      return false;
    }
  }
}
