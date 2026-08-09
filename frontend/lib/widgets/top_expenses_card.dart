import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';

class TopExpensesCard extends StatelessWidget {
  const TopExpensesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();

    final expenses = [...provider.expenses];

    expenses.sort((a, b) => b.amount.compareTo(a.amount));

    final topExpenses = expenses.length > 5 ? expenses.sublist(0, 5) : expenses;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xff111827),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.cyanAccent.withOpacity(.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "🔥 Top 5 Expenses",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          if (topExpenses.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "No expenses found",
                  style: TextStyle(color: Colors.white54),
                ),
              ),
            ),

          ...topExpenses.map(
            (expense) => Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.cyanAccent,
                    child: const Icon(
                      Icons.currency_rupee,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          expense.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          expense.category,
                          style: const TextStyle(color: Colors.white54),
                        ),
                      ],
                    ),
                  ),

                  Text(
                    "₹${expense.amount.toStringAsFixed(0)}",
                    style: const TextStyle(
                      color: Colors.greenAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
