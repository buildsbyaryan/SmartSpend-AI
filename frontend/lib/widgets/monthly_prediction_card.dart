import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';

class MonthlyPredictionCard extends StatelessWidget {
  const MonthlyPredictionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();

    final predicted = provider.predictedMonthExpense;
    final budget = provider.monthlyBudget;

    final bool overBudget = budget > 0 && predicted > budget;

    final double progress = budget == 0
        ? 0
        : (predicted / budget).clamp(0.0, 1.0);

    final Color color = overBudget
        ? Colors.redAccent
        : progress > .8
        ? Colors.orange
        : Colors.greenAccent;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: const LinearGradient(
          colors: [Color(0xff111827), Color(0xff1E293B)],
        ),
        border: Border.all(color: color.withOpacity(.4)),
        boxShadow: [BoxShadow(color: color.withOpacity(.15), blurRadius: 20)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome, color: color, size: 30),
              const SizedBox(width: 10),
              const Text(
                "AI Monthly Prediction",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 1200),
            tween: Tween(begin: 0, end: progress),
            builder: (_, value, __) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  value: value,
                  minHeight: 14,
                  backgroundColor: Colors.white12,
                  color: color,
                ),
              );
            },
          ),

          const SizedBox(height: 25),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Predicted",
                    style: TextStyle(color: Colors.white54),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "₹${predicted.toStringAsFixed(0)}",
                    style: TextStyle(
                      color: color,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text("Budget", style: TextStyle(color: Colors.white54)),

                  const SizedBox(height: 5),

                  Text(
                    budget == 0 ? "--" : "₹${budget.toStringAsFixed(0)}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 25),

          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: color.withOpacity(.10),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: color),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  overBudget ? Icons.warning_amber : Icons.check_circle,
                  color: color,
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    overBudget
                        ? "AI predicts you'll exceed your monthly budget. Try reducing discretionary expenses."
                        : "You're likely to stay within budget if your current spending pattern continues.",
                    style: const TextStyle(color: Colors.white, height: 1.5),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          if (budget > 0)
            Text(
              "Remaining Budget: ₹${(budget - predicted).toStringAsFixed(0)}",
              style: TextStyle(
                color: overBudget ? Colors.redAccent : Colors.greenAccent,
                fontWeight: FontWeight.bold,
              ),
            ),

          const SizedBox(height: 10),

          Text(
            overBudget ? "⚠ AI Confidence : High" : "✅ AI Confidence : High",
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
