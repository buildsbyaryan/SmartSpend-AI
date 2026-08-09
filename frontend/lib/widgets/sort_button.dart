import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/sort_type.dart';
import '../providers/expense_provider.dart';

class SortButton extends StatelessWidget {
  const SortButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SortType>(
      color: const Color(0xff101827),
      elevation: 12,

      onSelected: (value) {
        context.read<ExpenseProvider>().changeSort(value);
      },

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),

      itemBuilder: (_) => [
        buildItem(Icons.access_time, "Latest First", SortType.latest),
        buildItem(Icons.history, "Oldest First", SortType.oldest),
        buildItem(Icons.trending_up, "Highest Amount", SortType.highest),
        buildItem(Icons.trending_down, "Lowest Amount", SortType.lowest),
        buildItem(Icons.sort_by_alpha, "A - Z", SortType.alphabet),
      ],

      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: const LinearGradient(
            colors: [Color(0xff111827), Color(0xff1E293B)],
          ),
          border: Border.all(color: Colors.cyanAccent.withOpacity(.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.cyanAccent.withOpacity(.25),
              blurRadius: 15,
            ),
          ],
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.sort_rounded, color: Colors.cyanAccent, size: 20),
            SizedBox(width: 8),
            Text(
              "Sort",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 5),
            Icon(Icons.keyboard_arrow_down, color: Colors.white70),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<SortType> buildItem(
    IconData icon,
    String title,
    SortType type,
  ) {
    return PopupMenuItem(
      value: type,
      child: Row(
        children: [
          Icon(icon, color: Colors.cyanAccent),
          const SizedBox(width: 12),
          Text(title, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
