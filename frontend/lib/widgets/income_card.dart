import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/income_model.dart';
import '../providers/income_provider.dart';

class IncomeCard extends StatelessWidget {
  final Income income;

  const IncomeCard({super.key, required this.income});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white10,

        borderRadius: BorderRadius.circular(20),

        border: Border.all(color: Colors.greenAccent.withOpacity(0.3)),
      ),

      child: Row(
        children: [
          // ICON
          Container(
            height: 50,

            width: 50,

            decoration: BoxDecoration(
              color: Colors.greenAccent.withOpacity(.15),

              borderRadius: BorderRadius.circular(15),
            ),

            child: const Icon(Icons.arrow_downward, color: Colors.greenAccent),
          ),

          const SizedBox(width: 15),

          // DETAILS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  income.title,

                  style: const TextStyle(
                    color: Colors.white,

                    fontSize: 18,

                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  income.category,

                  style: const TextStyle(color: Colors.white54),
                ),

                const SizedBox(height: 5),

                Text(
                  "${income.date.day}/${income.date.month}/${income.date.year}",

                  style: const TextStyle(color: Colors.white38, fontSize: 12),
                ),
              ],
            ),
          ),

          // AMOUNT
          Column(
            children: [
              Text(
                "+ ₹${income.amount.toStringAsFixed(0)}",

                style: const TextStyle(
                  color: Colors.greenAccent,

                  fontSize: 18,

                  fontWeight: FontWeight.bold,
                ),
              ),

              IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent),

                onPressed: () async {
                  final provider = context.read<IncomeProvider>();

                  final success = await provider.deleteIncome(income.id);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        success ? "Income Deleted" : "Delete Failed",
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
