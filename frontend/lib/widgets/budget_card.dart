import 'package:flutter/material.dart';

import '../models/budget_model.dart';

class BudgetCard extends StatelessWidget {
  final Budget? budget;
  final double expense;

  const BudgetCard({super.key, required this.budget, required this.expense});

  @override
  Widget build(BuildContext context) {
    // NO BUDGET
    if (budget == null) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),

        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.orangeAccent.withOpacity(.3)),
        ),

        child: const Row(
          children: [
            Icon(
              Icons.account_balance_wallet,
              color: Colors.orangeAccent,
              size: 35,
            ),

            SizedBox(width: 15),

            Text(
              "No Budget Set",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }
    double totalBudget = budget!.limit;

    double remaining = totalBudget - expense;

    double progress = totalBudget == 0 ? 0 : expense / totalBudget;

    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.greenAccent.withOpacity(.15), Colors.white10],
        ),

        borderRadius: BorderRadius.circular(22),

        border: Border.all(color: Colors.greenAccent.withOpacity(.3)),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              const Icon(Icons.savings, color: Colors.greenAccent),

              const SizedBox(width: 10),

              const Text(
                "Monthly Budget",

                style: TextStyle(
                  color: Colors.white,

                  fontSize: 22,

                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Text(
            "₹${totalBudget.toStringAsFixed(0)}",

            style: const TextStyle(
              color: Colors.greenAccent,

              fontSize: 28,

              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            remaining >= 0
                ? "Remaining ₹${remaining.toStringAsFixed(0)}"
                : "Over Budget ₹${(-remaining).toStringAsFixed(0)}",

            style: TextStyle(
              color: remaining >= 0 ? Colors.greenAccent : Colors.redAccent,

              fontSize: 17,

              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          LinearProgressIndicator(
            value: progress > 1 ? 1 : progress,

            minHeight: 10,

            borderRadius: BorderRadius.circular(10),

            backgroundColor: Colors.white24,

            color: progress > 1 ? Colors.redAccent : Colors.greenAccent,
          ),

          const SizedBox(height: 12),

          Text(
            "Spent ₹${expense.toStringAsFixed(0)} / ₹${totalBudget.toStringAsFixed(0)}",

            style: const TextStyle(color: Colors.white70, fontSize: 15),
          ),

          const SizedBox(height: 5),

          Text(
            "${(progress * 100).clamp(0, 100).toStringAsFixed(0)}% Used",

            style: const TextStyle(color: Colors.white54),
          ),
        ],
      ),
    );
  }
}
