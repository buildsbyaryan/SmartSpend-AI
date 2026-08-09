import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CategoryChart extends StatelessWidget {
  final Map<String, double> data;

  const CategoryChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(
        child: Text("No Data", style: TextStyle(color: Colors.white54)),
      );
    }

    return SizedBox(
      height: 250,

      child: PieChart(
        PieChartData(
          sections: data.entries.map((entry) {
            return PieChartSectionData(
              value: entry.value,

              title: entry.key,

              radius: 70,

              titleStyle: const TextStyle(color: Colors.white, fontSize: 12),
            );
          }).toList(),
        ),
      ),
    );
  }
}
