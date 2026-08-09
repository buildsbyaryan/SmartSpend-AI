import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/expense_provider.dart';

class PieChartCard extends StatelessWidget {
  const PieChartCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();

    final expenses = provider.filteredAnalyticsExpenses;

    if (expenses.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: const Color(0xff111827),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.cyanAccent.withOpacity(.3)),
        ),
        child: const Column(
          children: [
            Icon(Icons.pie_chart_outline, color: Colors.white30, size: 70),
            SizedBox(height: 15),
            Text(
              "No Data Available",
              style: TextStyle(color: Colors.white54, fontSize: 18),
            ),
          ],
        ),
      );
    }

    final data = provider.analyticsCategoryWiseExpense;

    final categories = data.keys.toList();
    final values = data.values.toList();

    final total = values.fold<double>(
      0,
      (previousValue, element) => previousValue + element,
    );

    final colors = [
      Colors.orange,
      Colors.blue,
      Colors.purple,
      Colors.red,
      Colors.green,
      Colors.cyan,
      Colors.teal,
      Colors.pink,
      Colors.amber,
      Colors.indigo,
      Colors.deepOrange,
      Colors.lime,
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xff111827),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.cyanAccent.withOpacity(.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Category Distribution",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Center(
            child: SizedBox(
              height: 260,
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: 55,
                  sectionsSpace: 4,
                  sections: List.generate(categories.length, (index) {
                    final amount = values[index];

                    final percentage = total == 0 ? 0 : (amount / total) * 100;

                    return PieChartSectionData(
                      color: colors[index % colors.length],
                      value: amount,
                      radius: 72,
                      title: "${percentage.toStringAsFixed(0)}%",
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            "Categories",
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          Column(
            children: List.generate(categories.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 7,
                      backgroundColor: colors[index % colors.length],
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        categories[index],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),

                    Text(
                      "₹${values[index].toStringAsFixed(0)}",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),

          const Divider(color: Colors.white24, height: 35),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total Expense",
                style: TextStyle(color: Colors.white54, fontSize: 16),
              ),
              Text(
                "₹${total.toStringAsFixed(0)}",
                style: const TextStyle(
                  color: Colors.cyanAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
