import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/expense_provider.dart';

class FinancialHealthCard extends StatelessWidget {
  const FinancialHealthCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();

    final score = provider.financialHealthScore;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 700),
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xff111827),
            Color(0xff1E293B),
          ],
        ),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: provider.healthColor.withOpacity(.35),
        ),
        boxShadow: [
          BoxShadow(
            color: provider.healthColor.withOpacity(.18),
            blurRadius: 18,
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Row(
            children: [

              Icon(
                Icons.favorite,
                color: Colors.redAccent,
              ),

              SizedBox(width: 10),

              Text(
                "Financial Health",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [

                SizedBox(
                  height: 160,
                  width: 160,
                  child: CircularProgressIndicator(
                    value: score / 100,
                    strokeWidth: 12,
                    backgroundColor: Colors.white10,
                    valueColor: AlwaysStoppedAnimation(
                      provider.healthColor,
                    ),
                  ),
                ),

                Column(
                  children: [

                    Text(
                      "$score",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Text(
                      "Score",
                      style: TextStyle(
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          _tile(
            Icons.show_chart,
            "Expense Trend",
            provider.expenseTrend,
            Colors.orange,
          ),

          const SizedBox(height: 15),

          _tile(
            Icons.savings,
            "Savings Rate",
            provider.savingsRate,
            Colors.greenAccent,
          ),

          const SizedBox(height: 15),

          _tile(
            Icons.warning_amber,
            "Risk Level",
            provider.riskLevel,
            Colors.redAccent,
          ),

          const SizedBox(height: 15),

          _tile(
            Icons.workspace_premium,
            "Achievement",
            provider.achievementBadge,
            Colors.amber,
          ),

          const SizedBox(height: 25),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.05),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Text(
              provider.healthAdvice,
              style: const TextStyle(
                color: Colors.white,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tile(
      IconData icon,
      String title,
      String value,
      Color color,
      ) {

    return Row(
      children: [

        Icon(icon,color: color),

        const SizedBox(width: 15),

        Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
          ),
        ),

        const Spacer(),

        Text(
          value,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}