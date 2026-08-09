import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/expense_provider.dart';

class CategoryFilter extends StatelessWidget {
  const CategoryFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();

    final categories = [
      {"title": "All", "icon": Icons.apps_rounded},
      {"title": "Food", "icon": Icons.restaurant_rounded},
      {"title": "Travel", "icon": Icons.flight_takeoff_rounded},
      {"title": "Shopping", "icon": Icons.shopping_bag_rounded},
      {"title": "Bills", "icon": Icons.receipt_long_rounded},
      {"title": "Health", "icon": Icons.favorite_rounded},
    ];

    return SizedBox(
      height: 55,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = categories[index];

          final title = item["title"] as String;
          final icon = item["icon"] as IconData;

          final selected = provider.selectedCategory == title;

          return GestureDetector(
            onTap: () {
              provider.changeCategory(title);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),

                gradient: selected
                    ? const LinearGradient(
                        colors: [Color(0xff00E5FF), Color(0xff00B8D4)],
                      )
                    : const LinearGradient(
                        colors: [Color(0xff111827), Color(0xff1E293B)],
                      ),

                border: Border.all(
                  color: selected ? Colors.cyanAccent : Colors.white24,
                ),

                boxShadow: selected
                    ? [
                        BoxShadow(
                          color: Colors.cyanAccent.withOpacity(.45),
                          blurRadius: 18,
                          spreadRadius: 2,
                        ),
                      ]
                    : [],
              ),
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: 18,
                    color: selected ? Colors.black : Colors.cyanAccent,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: TextStyle(
                      color: selected ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
