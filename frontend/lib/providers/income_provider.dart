import 'package:flutter/material.dart';

import '../models/income_model.dart';
import '../backend/services/income_service.dart';

class IncomeProvider extends ChangeNotifier {
  List<Income> _incomeList = [];

  bool _isLoading = false;

  List<Income> get incomeList => _incomeList;

  bool get isLoading => _isLoading;

  // =========================
  // GET ALL INCOME
  // =========================

  Future<void> fetchIncome() async {
    try {
      _isLoading = true;
      notifyListeners();

      _incomeList = await IncomeService.getIncome();
    } catch (e) {
      print("Fetch Income Error : $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  // =========================
  // ADD INCOME
  // =========================

  Future<bool> addIncome(Income income) async {
    try {
      final success = await IncomeService.addIncome(income);

      if (success) {
        await fetchIncome();

        return true;
      }
    } catch (e) {
      print("Add Income Error : $e");
    }

    return false;
  }

  // =========================
  // UPDATE INCOME
  // =========================

  Future<bool> updateIncome(String id, Income income) async {
    try {
      final success = await IncomeService.updateIncome(id, income);

      if (success) {
        await fetchIncome();

        return true;
      }
    } catch (e) {
      print("Update Income Error : $e");
    }

    return false;
  }

  // =========================
  // DELETE INCOME
  // =========================

  Future<bool> deleteIncome(String id) async {
    try {
      final success = await IncomeService.deleteIncome(id);

      if (success) {
        _incomeList.removeWhere((income) => income.id == id);

        notifyListeners();

        return true;
      }
    } catch (e) {
      print("Delete Income Error : $e");
    }

    return false;
  }

  // =========================
  // TOTAL INCOME
  // =========================

  double get totalIncome {
    double total = 0;

    for (var income in _incomeList) {
      total += income.amount;
    }

    return total;
  }
}
