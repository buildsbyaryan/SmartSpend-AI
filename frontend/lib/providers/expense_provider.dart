import 'package:flutter/material.dart';
import '../models/sort_type.dart';
import '../models/expense_model.dart';
import '../services/storage_service.dart';
import '../services/expense_service.dart';

class ExpenseProvider extends ChangeNotifier {
  final List<Expense> _expenses = [];
  String _searchQuery = "";

  String get searchQuery => _searchQuery;
  String _selectedCategory = "All";

  String get selectedCategory => _selectedCategory;

  SortType _sortType = SortType.latest;

  SortType get sortType => _sortType;

  double _monthlyBudget = 0;

  double get monthlyBudget => _monthlyBudget;

  List<Expense> get expenses => _expenses;

  String _selectedRange = "Month";

  String get selectedRange => _selectedRange;

  Future<bool> addExpense(Expense expense) async {
    final success = await ExpenseService.addExpense(expense);

    if (success) {
      await ExpenseService.getExpenses(); // reload list
      return true;
    }

    return false;
  }

  void changeCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void changeSort(SortType sort) {
    _sortType = sort;
    notifyListeners();
  }

  Future<void> updateExpense(Expense expense, int index) async {
    if (expense.id == null) return;

    bool success = await ExpenseService.updateExpense(expense.id!, expense);

    if (success) {
      _expenses[index] = expense;
      notifyListeners();
    }
  }

  Future<void> deleteExpense(int index) async {
    // _expenses.removeAt(index);

    // await StorageService.saveExpenses(_expenses);

    // notifyListeners();

    final expense = _expenses[index];

    if (expense.id == null) return;

    bool success = await ExpenseService.deleteExpense(expense.id!);

    if (success) {
      _expenses.removeAt(index);
      notifyListeners();
    }
  }

  Future<void> loadData() async {
    // _expenses.clear();

    // _expenses.addAll(await StorageService.loadExpenses());

    // _monthlyBudget = await StorageService.loadBudget();

    // notifyListeners();
    _expenses.clear();

    final data = await ExpenseService.getExpenses();

    _expenses.addAll(data);

    notifyListeners();
  }

  Future<void> setBudget(double amount) async {
    _monthlyBudget = amount;

    await StorageService.saveBudget(amount);

    notifyListeners();
  }

  double get remainingBudget {
    return _monthlyBudget - totalExpense;
  }

  double get budgetProgress {
    if (_monthlyBudget == 0) return 0;

    double progress = totalExpense / _monthlyBudget;

    return progress > 1 ? 1 : progress;
  }

  String get budgetStatus {
    if (_monthlyBudget == 0) {
      return "No Budget Set";
    }

    if (totalExpense >= _monthlyBudget) {
      return "Budget Exceeded";
    }

    if (budgetProgress > .8) {
      return "Budget Almost Finished";
    }

    return "Budget Healthy";
  }

  String get budgetAdvice {
    if (_monthlyBudget == 0) {
      return "Set your monthly budget.";
    }

    if (totalExpense >= _monthlyBudget) {
      return "You exceeded your budget. Reduce unnecessary spending.";
    }

    if (budgetProgress > .8) {
      return "You have used more than 80% of your budget.";
    }

    return "Great! Your spending is under control.";
  }

  void searchExpense(String query) {
    _searchQuery = query;

    notifyListeners();
  }

  List<Expense> get filteredExpenses {
    List<Expense> list = List.from(_expenses);

    // Search Filter
    if (_searchQuery.isNotEmpty) {
      list = list.where((expense) {
        return expense.title.toLowerCase().contains(
              _searchQuery.toLowerCase(),
            ) ||
            expense.category.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    // Category Filter
    if (_selectedCategory != "All") {
      list = list.where((expense) {
        return expense.category == _selectedCategory;
      }).toList();
    }

    switch (_sortType) {
      case SortType.latest:
        list.sort((a, b) => b.date.compareTo(a.date));
        break;

      case SortType.oldest:
        list.sort((a, b) => a.date.compareTo(b.date));
        break;

      case SortType.highest:
        list.sort((a, b) => b.amount.compareTo(a.amount));
        break;

      case SortType.lowest:
        list.sort((a, b) => a.amount.compareTo(b.amount));
        break;

      case SortType.alphabet:
        list.sort((a, b) => a.title.compareTo(b.title));
        break;
    }

    return list;
  }

  // TOTAL EXPENSE

  double get totalExpense {
    double total = 0;

    for (var expense in _expenses) {
      total += expense.amount;
    }

    return total;
  }

  // TOTAL TRANSACTIONS

  int get totalTransactions {
    return _expenses.length;
  }

  // AVERAGE EXPENSE

  double get averageExpense {
    if (_expenses.isEmpty) {
      return 0;
    }

    return totalExpense / _expenses.length;
  }

  // CATEGORY WISE EXPENSE

  double getCategoryAmount(String category) {
    double total = 0;

    for (var expense in _expenses) {
      if (expense.category == category) {
        total += expense.amount;
      }
    }

    return total;
  }

  // HIGHEST SPENDING CATEGORY FOR AI

  String getHighestCategory() {
    if (_expenses.isEmpty) {
      return "No Data";
    }

    Map<String, double> categoryData = {};

    for (var expense in _expenses) {
      categoryData[expense.category] =
          (categoryData[expense.category] ?? 0) + expense.amount;
    }

    String highest = categoryData.keys.first;

    categoryData.forEach((key, value) {
      if (value > categoryData[highest]!) {
        highest = key;
      }
    });

    return highest;
  }

  // MONTHLY AI WARNING

  String getMonthlyStatus() {
    if (totalExpense > 10000) {
      return "⚠️ Your monthly spending is high. "
          "Try saving more money.";
    } else {
      return "✅ Your spending is under control.";
    }
  }

  // Highest Expense

  double get highestExpense {
    if (_expenses.isEmpty) return 0;

    double highest = _expenses.first.amount;

    for (var expense in _expenses) {
      if (expense.amount > highest) {
        highest = expense.amount;
      }
    }

    return highest;
  }

  // This Month Expense

  double get thisMonthExpense {
    final now = DateTime.now();

    double total = 0;

    for (var expense in _expenses) {
      if (expense.date.month == now.month && expense.date.year == now.year) {
        total += expense.amount;
      }
    }

    return total;
  }

  // This Week Expense

  double get thisWeekExpense {
    final now = DateTime.now();

    double total = 0;

    for (var expense in _expenses) {
      final difference = now.difference(expense.date).inDays;

      if (difference <= 7 && difference >= 0) {
        total += expense.amount;
      }
    }

    return total;
  }

  List<double> getMonthlyExpenses() {
    List<double> months = List.filled(12, 0);

    for (var expense in _expenses) {
      months[expense.date.month - 1] += expense.amount;
    }

    return months;
  }

  List<double> getWeeklyExpenses() {
    List<double> week = List.filled(7, 0);

    for (var expense in _expenses) {
      int day = expense.date.weekday - 1;
      week[day] += expense.amount;
    }

    return week;
  }

  int get spendingScore {
    if (_expenses.isEmpty) return 100;

    int score = 100;

    if (totalExpense > monthlyBudget && monthlyBudget > 0) {
      score -= 30;
    }

    if (averageExpense > 1000) {
      score -= 15;
    }

    if (totalTransactions > 50) {
      score -= 10;
    }

    if (getHighestCategory() == "Shopping") {
      score -= 10;
    }

    if (getHighestCategory() == "Food") {
      score -= 5;
    }

    if (score < 0) score = 0;

    return score;
  }

  String get spendingGrade {
    final score = spendingScore;

    if (score >= 90) {
      return "Excellent";
    }

    if (score >= 75) {
      return "Good";
    }

    if (score >= 60) {
      return "Average";
    }

    if (score >= 40) {
      return "Poor";
    }

    return "Critical";
  }

  Color get spendingColor {
    final score = spendingScore;

    if (score >= 90) {
      return Colors.greenAccent;
    }

    if (score >= 75) {
      return Colors.lightGreen;
    }

    if (score >= 60) {
      return Colors.orangeAccent;
    }

    if (score >= 40) {
      return Colors.deepOrange;
    }

    return Colors.redAccent;
  }

  void changeRange(String range) {
    _selectedRange = range;
    notifyListeners();
  }

  List<Expense> get rangeExpenses {
    final now = DateTime.now();

    switch (_selectedRange) {
      case "Today":
        return expenses.where((e) {
          return e.date.year == now.year &&
              e.date.month == now.month &&
              e.date.day == now.day;
        }).toList();

      case "Week":
        return expenses.where((e) {
          return now.difference(e.date).inDays <= 7;
        }).toList();

      case "Month":
        return expenses.where((e) {
          return e.date.month == now.month && e.date.year == now.year;
        }).toList();

      case "Year":
        return expenses.where((e) {
          return e.date.year == now.year;
        }).toList();

      default:
        return expenses;
    }
  }

  Map<String, double> get categoryWiseExpense {
    final Map<String, double> data = {};

    for (final expense in rangeExpenses) {
      data.update(
        expense.category,
        (value) => value + expense.amount,
        ifAbsent: () => expense.amount,
      );
    }

    return data;
  }

  List<Expense> get filteredAnalyticsExpenses {
    return rangeExpenses;
  }

  double get analyticsTotalExpense {
    double total = 0;

    for (final expense in rangeExpenses) {
      total += expense.amount;
    }

    return total;
  }

  int get analyticsTransactions {
    return rangeExpenses.length;
  }

  double get analyticsAverageExpense {
    if (rangeExpenses.isEmpty) return 0;

    return analyticsTotalExpense / rangeExpenses.length;
  }

  String get analyticsHighestCategory {
    if (filteredAnalyticsExpenses.isEmpty) {
      return "No Data";
    }

    final Map<String, double> data = {};

    for (final expense in filteredAnalyticsExpenses) {
      data.update(
        expense.category,
        (value) => value + expense.amount,
        ifAbsent: () => expense.amount,
      );
    }

    String highest = data.keys.first;

    data.forEach((key, value) {
      if (value > data[highest]!) {
        highest = key;
      }
    });

    return highest;
  }

  Map<String, double> get analyticsCategoryWiseExpense {
    final Map<String, double> data = {};

    for (final expense in filteredAnalyticsExpenses) {
      data.update(
        expense.category,
        (value) => value + expense.amount,
        ifAbsent: () => expense.amount,
      );
    }

    return data;
  }

  String get highestSpendingDay {
    if (_expenses.isEmpty) return "No Data";

    final Map<int, double> data = {};

    for (final expense in _expenses) {
      data.update(
        expense.date.weekday,
        (value) => value + expense.amount,
        ifAbsent: () => expense.amount,
      );
    }

    int highestDay = data.keys.first;

    data.forEach((day, amount) {
      if (amount > data[highestDay]!) {
        highestDay = day;
      }
    });

    const days = [
      "",
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday",
    ];

    return days[highestDay];
  }

  double get highestSpendingDayAmount {
    if (_expenses.isEmpty) return 0;

    final Map<int, double> data = {};

    for (final expense in _expenses) {
      data.update(
        expense.date.weekday,
        (value) => value + expense.amount,
        ifAbsent: () => expense.amount,
      );
    }

    double highest = 0;

    data.forEach((day, amount) {
      if (amount > highest) {
        highest = amount;
      }
    });

    return highest;
  }

  double get predictedMonthExpense {
    if (_expenses.isEmpty) return 0;

    final now = DateTime.now();

    final currentMonth = _expenses.where((e) {
      return e.date.month == now.month && e.date.year == now.year;
    }).toList();

    if (currentMonth.isEmpty) return 0;

    double spent = 0;

    for (var e in currentMonth) {
      spent += e.amount;
    }

    final daysPassed = now.day;
    final totalDays = DateTime(now.year, now.month + 1, 0).day;

    return (spent / daysPassed) * totalDays;
  }

  Map<int, double> get dailyExpenseMap {
    final Map<int, double> map = {};

    final now = DateTime.now();

    for (final expense in rangeExpenses) {
      if (expense.date.month == now.month && expense.date.year == now.year) {
        map.update(
          expense.date.day,
          (value) => value + expense.amount,
          ifAbsent: () => expense.amount,
        );
      }
    }

    return map;
  }

  String get highestExpenseCategory {
    if (categoryWiseExpense.isEmpty) {
      return "No Data";
    }

    String highest = categoryWiseExpense.keys.first;

    categoryWiseExpense.forEach((key, value) {
      if (value > categoryWiseExpense[highest]!) {
        highest = key;
      }
    });

    return highest;
  }

  double get highestCategoryAmount {
    if (categoryWiseExpense.isEmpty) {
      return 0;
    }

    return categoryWiseExpense[highestExpenseCategory] ?? 0;
  }

  String get aiSavingTip {
    switch (highestExpenseCategory) {
      case "Food":
        return "🍽 Try meal planning and home cooking to reduce food expenses.";

      case "Shopping":
        return "🛍 Delay non-essential purchases for 24 hours before buying.";

      case "Travel":
        return "🚗 Use public transport or carpool to lower travel costs.";

      case "Bills":
        return "💡 Save electricity and water to reduce monthly utility bills.";

      case "Health":
        return "🏃 Preventive care and regular exercise may help reduce future medical expenses.";

      default:
        return "📈 Keep tracking your expenses to discover more saving opportunities.";
    }
  }

  int get financialHealthScore {
    int score = 100;

    if (monthlyBudget > 0 && analyticsTotalExpense > monthlyBudget) {
      score -= 30;
    }

    if (analyticsAverageExpense > 1000) {
      score -= 15;
    }

    if (highestExpenseCategory == "Shopping") {
      score -= 10;
    }

    if (analyticsTransactions > 40) {
      score -= 10;
    }

    if (score < 0) score = 0;

    return score;
  }

  Color get healthColor {
    if (financialHealthScore >= 90) {
      return Colors.green;
    }

    if (financialHealthScore >= 75) {
      return Colors.lightGreen;
    }

    if (financialHealthScore >= 60) {
      return Colors.orange;
    }

    return Colors.redAccent;
  }

  String get expenseTrend {
    if (analyticsTransactions == 0) {
      return "No Data";
    }

    if (analyticsAverageExpense < 500) {
      return "Improving";
    }

    if (analyticsAverageExpense < 1000) {
      return "Stable";
    }

    return "Increasing";
  }

  String get savingsRate {
    if (monthlyBudget == 0) {
      return "--";
    }

    final rate =
        ((monthlyBudget - analyticsTotalExpense) / monthlyBudget) * 100;

    return "${rate.clamp(0, 100).toStringAsFixed(0)}%";
  }

  String get achievementBadge {
    if (financialHealthScore >= 90) {
      return "🏆 Budget Master";
    }

    if (financialHealthScore >= 75) {
      return "🥇 Smart Saver";
    }

    if (financialHealthScore >= 60) {
      return "⭐ Consistent Tracker";
    }

    return "⚠ Needs Improvement";
  }

  String get healthAdvice {
    if (financialHealthScore >= 90) {
      return "🎉 Excellent financial discipline! Keep following your current spending habits.";
    }

    if (financialHealthScore >= 75) {
      return "✅ Good financial health. You can improve further by reducing discretionary expenses.";
    }

    if (financialHealthScore >= 60) {
      return "⚠ Your financial health is average. Review your top spending categories.";
    }

    return "🚨 Your spending pattern is risky. Consider reducing expenses and sticking to your monthly budget.";
  }

  String get riskLevel {
    if (financialHealthScore >= 80) {
      return "Low";
    }

    if (financialHealthScore >= 60) {
      return "Medium";
    }

    return "High";
  }
}
