import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';

class DateFilter extends StatelessWidget {
  const DateFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();

    final filters = [
      "Today",
      "Week",
      "Month",
      "Year",
      "All",
    ];

    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final filter = filters[index];

          final selected = provider.selectedRange == filter;

          return GestureDetector(
            onTap: () {
              provider.changeRange(filter);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: selected
                    ? const LinearGradient(
                        colors: [
                          Colors.cyanAccent,
                          Color(0xff00BCD4),
                        ],
                      )
                    : null,
                color: selected ? null : Colors.white10,
                border: Border.all(
                  color: selected
                      ? Colors.transparent
                      : Colors.white24,
                ),
                boxShadow: selected
                    ? [
                        BoxShadow(
                          color: Colors.cyanAccent.withOpacity(.45),
                          blurRadius: 14,
                          spreadRadius: 1,
                        ),
                      ]
                    : [],
              ),
              child: Center(
                child: Text(
                  filter,
                  style: TextStyle(
                    color: selected ? Colors.black : Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}