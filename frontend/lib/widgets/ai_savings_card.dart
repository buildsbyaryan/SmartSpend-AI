import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/expense_provider.dart';

class AiSavingsCard extends StatelessWidget {
  const AiSavingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();

    final category = provider.highestExpenseCategory;

    final amount = provider.highestCategoryAmount;

    final saving = amount * .15;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 700),
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff111827), Color(0xff1E293B)],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.greenAccent.withOpacity(.35)),
        boxShadow: [
          BoxShadow(color: Colors.greenAccent.withOpacity(.12), blurRadius: 18),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.lightbulb, color: Colors.greenAccent),

              SizedBox(width: 10),

              Text(
                "AI Savings Opportunities",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              const Icon(Icons.trending_up, color: Colors.orange),

              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  "Highest spending category is $category",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          Row(
            children: [
              const Icon(
                Icons.account_balance_wallet,
                color: Colors.cyanAccent,
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  "Spent ₹${amount.toStringAsFixed(0)} this month.",
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(.08),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Text(
              "💡 If you reduce $category expenses by just 15%, you can save approximately ₹${saving.toStringAsFixed(0)} every month.",
              style: const TextStyle(
                color: Colors.white,
                height: 1.5,
                fontSize: 16,
              ),
            ),
          ),

          const SizedBox(height: 18),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.cyan.withOpacity(.08),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Text(
              provider.aiSavingTip,
              style: const TextStyle(color: Colors.white70, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
