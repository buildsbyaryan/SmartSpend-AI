import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MonthlyChart extends StatelessWidget {
  final List<double> values;

  const MonthlyChart({super.key, required this.values});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,

      child: BarChart(
        BarChartData(
          barGroups: List.generate(values.length, (index) {
            return BarChartGroupData(
              x: index,

              barRods: [BarChartRodData(toY: values[index], width: 18)],
            );
          }),

          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,

                getTitlesWidget: (value, meta) {
                  return Text(
                    "${value.toInt() + 1}",

                    style: const TextStyle(color: Colors.white),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
