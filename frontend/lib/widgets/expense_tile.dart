import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/expense_model.dart';
import '../providers/expense_provider.dart';
import '../utils/date_formatter.dart';
import '../screens/add_expense_screen.dart';

class ExpenseTile extends StatelessWidget {
  final Expense expense;
  final int index;

  const ExpenseTile({super.key, required this.expense, required this.index});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ExpenseProvider>();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),

      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),

        gradient: const LinearGradient(
          colors: [Color(0xff232526), Color(0xff414345)],

          begin: Alignment.topLeft,

          end: Alignment.bottomRight,
        ),

        boxShadow: [
          BoxShadow(color: Colors.cyanAccent.withOpacity(0.15), blurRadius: 12),
        ],
      ),

      child: ListTile(
        contentPadding: EdgeInsets.zero,

        leading: CircleAvatar(
          radius: 28,

          backgroundColor: Colors.cyanAccent.withOpacity(0.2),

          child: Icon(
            getCategoryIcon(expense.category),

            color: Colors.cyanAccent,
          ),
        ),

        title: Text(
          expense.title,

          style: const TextStyle(
            color: Colors.white,

            fontWeight: FontWeight.bold,

            fontSize: 17,
          ),
        ),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const SizedBox(height: 5),

            Text(
              expense.category,

              style: const TextStyle(color: Colors.white70),
            ),

            const SizedBox(height: 5),

            Text(
              "${DateFormatter.formatDate(expense.date)} • ${DateFormatter.formatTime(expense.date)}",

              style: const TextStyle(color: Colors.white54, fontSize: 12),
            ),
          ],
        ),

        trailing: SizedBox(
          width: 120,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text(
                "\₹${expense.amount.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyanAccent,
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  InkWell(
                    child: const Icon(Icons.edit, size: 20, color: Colors.blue),

                    onTap: () {
                      Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder: (_) =>
                              AddExpenseScreen(expense: expense, index: index),
                        ),
                      );
                    },
                  ),

                  const SizedBox(width: 12),

                  InkWell(
                    child: const Icon(
                      Icons.delete,
                      size: 20,
                      color: Colors.red,
                    ),

                    onTap: () {
                      provider.deleteExpense(index);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case "food":
        return Icons.restaurant;

      case "travel":
        return Icons.flight;

      case "shopping":
        return Icons.shopping_bag;

      case "health":
        return Icons.health_and_safety;

      case "bills":
        return Icons.receipt_long;

      default:
        return Icons.money;
    }
  }
}
