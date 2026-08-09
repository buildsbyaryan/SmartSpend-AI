import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/expense_provider.dart';

class SearchExpenseBar extends StatelessWidget {
  const SearchExpenseBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [Color(0xff111827), Color(0xff1E293B)],
        ),
        border: Border.all(
          color: Colors.cyanAccent.withOpacity(.4),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withOpacity(.18),
            blurRadius: 20,
            spreadRadius: 1,
          ),
        ],
      ),
      child: TextField(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),

        cursorColor: Colors.cyanAccent,

        decoration: InputDecoration(
          border: InputBorder.none,

          hintText: "Search expenses...",

          hintStyle: const TextStyle(color: Colors.white38, fontSize: 16),

          prefixIcon: const Icon(
            Icons.search_rounded,
            color: Colors.cyanAccent,
            size: 28,
          ),

          suffixIcon: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.cyanAccent.withOpacity(.15),
            ),
            child: const Icon(Icons.auto_awesome, color: Colors.cyanAccent),
          ),

          contentPadding: const EdgeInsets.symmetric(vertical: 18),
        ),

        onChanged: (value) {
          context.read<ExpenseProvider>().searchExpense(value);
        },
      ),
    );
  }
}
