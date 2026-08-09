import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/expense_model.dart';

class StorageService {
  static const String budgetKey = "budget";

  static Future<void> saveBudget(double budget) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setDouble(budgetKey, budget);
  }

  static Future<double> loadBudget() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getDouble(budgetKey) ?? 0;
  }

  // Save Expenses
  static Future<void> saveExpenses(List<Expense> expenses) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> expenseList = expenses
        .map((expense) => jsonEncode(expense.toJson()))
        .toList();

    await prefs.setStringList("expenses", expenseList);
  }

  // Load Expenses
  static Future<List<Expense>> loadExpenses() async {
    final prefs = await SharedPreferences.getInstance();

    List<String>? expenseList = prefs.getStringList("expenses");

    if (expenseList == null) {
      return [];
    }

    return expenseList.map((expense) {
      return Expense.fromJson(jsonDecode(expense));
    }).toList();
  }

  // Clear All Data
  static Future<void> clearExpenses() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove("expenses");
  }
}
