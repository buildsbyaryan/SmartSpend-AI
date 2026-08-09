import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_spend_ai/providers/expense_provider.dart';


class CalendarHeatmapCard extends StatelessWidget {
  const CalendarHeatmapCard({super.key});

  Color _getColor(double amount) {
    if (amount == 0) {
      return Colors.grey.shade900;
    } else if (amount < 500) {
      return Colors.green;
    } else if (amount < 1000) {
      return Colors.lightGreen;
    } else if (amount < 2000) {
      return Colors.orange;
    } else {
      return Colors.redAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();

    final spending = provider.dailyExpenseMap;

    final now = DateTime.now();
    final totalDays = DateUtils.getDaysInMonth(now.year, now.month);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff111827), Color(0xff1E293B)],
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.cyanAccent.withOpacity(.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.calendar_month, color: Colors.cyanAccent),

              SizedBox(width: 10),

              Text(
                "Calendar Heatmap",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),

            itemCount: totalDays,

            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),

            itemBuilder: (context, index) {
              final day = index + 1;

              final amount = spending[day] ?? 0;

              return Tooltip(
                message: "Day $day\n₹${amount.toStringAsFixed(0)}",

                child: Container(
                  decoration: BoxDecoration(
                    color: _getColor(amount),
                    borderRadius: BorderRadius.circular(8),
                  ),

                  child: Center(
                    child: Text(
                      "$day",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 25),

          Wrap(
            spacing: 15,
            children: const [
              _Legend(color: Colors.green, text: "< ₹500"),

              _Legend(color: Colors.lightGreen, text: "₹500-1000"),

              _Legend(color: Colors.orange, text: "₹1000-2000"),

              _Legend(color: Colors.redAccent, text: "> ₹2000"),
            ],
          ),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String text;

  const _Legend({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),

        const SizedBox(width: 6),

        Text(text, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }
}
