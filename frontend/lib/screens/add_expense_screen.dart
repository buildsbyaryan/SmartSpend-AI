import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/expense_model.dart';
import '../providers/expense_provider.dart';

class AddExpenseScreen extends StatefulWidget {
  final Expense? expense;
  final int? index;

  const AddExpenseScreen({super.key, this.expense, this.index});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  String category = "Food";

  DateTime selectedDate = DateTime.now();

  final categories = ["Food", "Travel", "Shopping", "Bills", "Health"];

  @override
  void initState() {
    super.initState();

    if (widget.expense != null) {
      titleController.text = widget.expense!.title;

      amountController.text = widget.expense!.amount.toString();

      category = widget.expense!.category;

      selectedDate = widget.expense!.date;
    }

    Future.microtask(() {
      context.read<ExpenseProvider>().loadData();
    });
  }

  // void saveExpense() {
  //   if (titleController.text.isEmpty || amountController.text.isEmpty) {
  //     return;
  //   }

  //   final expense = Expense(
  //     title: titleController.text,

  //     amount: double.parse(amountController.text),

  //     category: category,

  //     date: selectedDate,
  //   );

  //   final provider = context.read<ExpenseProvider>();

  //   if (widget.expense == null) {
  //     provider.addExpense(expense);
  //   } else {
  //     provider.updateExpense(expense, widget.index!);
  //   }

  //   Navigator.pop(context);
  // }

  Future<void> saveExpense() async {
    if (titleController.text.isEmpty || amountController.text.isEmpty) {
      return;
    }

    final expense = Expense(
      id: widget.expense?.id,
      title: titleController.text,
      amount: double.parse(amountController.text),
      category: category,
      date: selectedDate,
    );

    final provider = context.read<ExpenseProvider>();

    if (widget.expense == null) {
      await provider.addExpense(expense);
    } else {
      await provider.updateExpense(expense, widget.index!);
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff050505),

      appBar: AppBar(
        backgroundColor: Colors.transparent,

        title: const Text(
          "Add Expense 🤖",

          style: TextStyle(color: Colors.white),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            futuristicInput(
              controller: titleController,

              hint: "Expense Name",

              icon: Icons.edit,
            ),

            const SizedBox(height: 20),

            futuristicInput(
              controller: amountController,

              hint: "Amount",

              icon: Icons.currency_rupee,

              keyboard: TextInputType.number,
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),

              decoration: BoxDecoration(
                color: Colors.white10,

                borderRadius: BorderRadius.circular(20),
              ),

              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  dropdownColor: Colors.black,

                  value: category,

                  isExpanded: true,

                  items: categories.map((item) {
                    return DropdownMenuItem(
                      value: item,

                      child: Text(
                        item,

                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),

                  onChanged: (value) {
                    setState(() {
                      category = value!;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(15),

              decoration: BoxDecoration(
                color: Colors.white10,

                borderRadius: BorderRadius.circular(20),
              ),

              child: Row(
                children: [
                  const Icon(Icons.calendar_month, color: Colors.cyanAccent),

                  const SizedBox(width: 15),

                  Text(
                    "${selectedDate.day}/"
                    "${selectedDate.month}/"
                    "${selectedDate.year}",

                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 35),

            SizedBox(
              width: double.infinity,

              height: 55,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyanAccent,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),

                onPressed: saveExpense,

                child: const Text(
                  "Save Expense",

                  style: TextStyle(
                    color: Colors.black,

                    fontSize: 18,

                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget futuristicInput({
    required TextEditingController controller,

    required String hint,

    required IconData icon,

    TextInputType keyboard = TextInputType.text,
  }) {
    return TextField(
      controller: controller,

      keyboardType: keyboard,

      style: const TextStyle(color: Colors.white),

      decoration: InputDecoration(
        hintText: hint,

        hintStyle: const TextStyle(color: Colors.white54),

        prefixIcon: Icon(icon, color: Colors.cyanAccent),

        filled: true,

        fillColor: Colors.white10,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),

          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
