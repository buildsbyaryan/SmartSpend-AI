import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/expense_provider.dart';

class HighestSpendingDayCard extends StatelessWidget {
  const HighestSpendingDayCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff111827), Color(0xff1E293B)],
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.orangeAccent.withOpacity(.35)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.calendar_today,
              color: Colors.orangeAccent,
              size: 32,
            ),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Highest Spending Day",
                  style: TextStyle(color: Colors.white54, fontSize: 15),
                ),

                const SizedBox(height: 6),

                Text(
                  provider.highestSpendingDay,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  "₹${provider.highestSpendingDayAmount.toStringAsFixed(0)}",
                  style: const TextStyle(
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
