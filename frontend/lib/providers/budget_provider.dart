import 'package:flutter/material.dart';

import '../backend/services/budget_service.dart';
import '../models/budget_model.dart';

class BudgetProvider extends ChangeNotifier {
  Budget? _budget;

  Budget? get budget => _budget;

  bool _loading = false;

  bool get loading => _loading;

  // ==========================
  // SET BUDGET
  // ==========================

  Future<bool> setBudget(Budget budget) async {
    _loading = true;

    notifyListeners();

    final success = await BudgetService.setBudget(budget);

    if (success) {
      _budget = budget;
    }

    _loading = false;

    notifyListeners();

    return success;
  }

  // ==========================
  // GET BUDGET
  // ==========================

  Future<void> fetchBudget() async {
    _loading = true;

    notifyListeners();

    final data = await BudgetService.getBudget();

    if (data != null) {
      _budget = data;
    }

    _loading = false;

    notifyListeners();
  }

  // ==========================
  // DELETE BUDGET
  // ==========================

  Future<bool> deleteBudget(String budgetId) async {
    final success = await BudgetService.deleteBudget(budgetId);

    if (success) {
      _budget = null;
    }

    notifyListeners();

    return success;
  }

  // ==========================
  // TOTAL BUDGET
  // ==========================

  double get totalBudget {
    if (_budget == null) {
      return 0;
    }

    return _budget!.limit;
  }

  // ==========================
  // REMAINING BUDGET
  // ==========================

  double remainingBudget(double expense) {
    if (_budget == null) {
      return 0;
    }

    return _budget!.limit - expense;
  }

  // ==========================
  // BUDGET PROGRESS
  // ==========================

  double budgetProgress(double expense) {
    if (_budget == null || _budget!.limit == 0) {
      return 0;
    }

    return expense / _budget!.limit;
  }
}
