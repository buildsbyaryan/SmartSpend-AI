import '../models/expense_model.dart';

class AIAnalyzer {
  static String getSuggestion(List<Expense> expenses) {
    if (expenses.isEmpty) {
      return "Add expenses to get AI suggestions 🤖";
    }

    double total = 0;

    Map<String, double> categories = {};

    for (var expense in expenses) {
      total += expense.amount;

      categories[expense.category] =
          (categories[expense.category] ?? 0) + expense.amount;
    }

    String highestCategory = categories.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;

    double highestAmount = categories[highestCategory]!;

    double percentage = (highestAmount / total) * 100;

    if (percentage > 40) {
      return "🤖 AI Suggestion:\n"
          "Your $highestCategory spending is "
          "${percentage.toStringAsFixed(0)}% of your expenses. "
          "Try reducing it this month.";
    }

    return "🤖 Great job! Your spending looks balanced.";
  }
}
