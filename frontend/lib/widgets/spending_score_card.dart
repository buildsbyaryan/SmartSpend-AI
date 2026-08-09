import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/expense_provider.dart';

class SpendingScoreCard extends StatelessWidget {
  const SpendingScoreCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff111827), Color(0xff1E293B)],
        ),

        borderRadius: BorderRadius.circular(24),

        border: Border.all(color: provider.spendingColor.withOpacity(.5)),
      ),

      child: Column(
        children: [
          const Text(
            "AI Spending Score",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 25),

          SizedBox(
            width: 170,
            height: 170,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 170,
                  height: 170,
                  child: CircularProgressIndicator(
                    value: provider.spendingScore / 100,
                    strokeWidth: 12,
                    backgroundColor: Colors.white12,
                    valueColor: AlwaysStoppedAnimation(provider.spendingColor),
                  ),
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${provider.spendingScore}",
                      style: TextStyle(
                        color: provider.spendingColor,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Text("/100", style: TextStyle(color: Colors.white54)),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),

            decoration: BoxDecoration(
              color: provider.spendingColor.withOpacity(.15),
              borderRadius: BorderRadius.circular(30),
            ),

            child: Text(
              provider.spendingGrade,
              style: TextStyle(
                color: provider.spendingColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "Your score is calculated using budget usage, transaction frequency, average spending and category analysis.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, height: 1.5),
          ),
        ],
      ),
    );
  }
}
