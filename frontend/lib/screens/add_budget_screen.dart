import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/budget_model.dart';
import '../providers/budget_provider.dart';

class AddBudgetScreen extends StatefulWidget {
  const AddBudgetScreen({super.key});

  @override
  State<AddBudgetScreen> createState() => _AddBudgetScreenState();
}

class _AddBudgetScreenState extends State<AddBudgetScreen> {
  final TextEditingController amountController = TextEditingController();

  String category = "Food";

  final categories = [
    "Food",
    "Travel",
    "Shopping",
    "Bills",
    "Entertainment",
    "Other",
  ];

  DateTime selectedMonth = DateTime.now();

  bool loading = false;

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  Future<void> saveBudget() async {
    if (amountController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Enter Budget Limit")));

      return;
    }

    final budget = Budget(
      category: category,

      limit: double.parse(amountController.text.trim()),

      month: selectedMonth.month,

      year: selectedMonth.year,
    );

    setState(() {
      loading = true;
    });

    final success = await context.read<BudgetProvider>().setBudget(budget);

    setState(() {
      loading = false;
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Budget Added Successfully")),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Budget Failed")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff050505),

      appBar: AppBar(
        backgroundColor: Colors.transparent,

        centerTitle: true,

        title: const Text(
          "Set Budget 💰",

          style: TextStyle(color: Colors.white),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(
              controller: amountController,

              keyboardType: TextInputType.number,

              style: const TextStyle(color: Colors.white),

              decoration: InputDecoration(
                hintText: "Budget Limit",

                hintStyle: const TextStyle(color: Colors.white54),

                prefixIcon: const Icon(
                  Icons.currency_rupee,

                  color: Colors.greenAccent,
                ),

                filled: true,

                fillColor: Colors.white10,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),

                  borderSide: BorderSide.none,
                ),
              ),
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
                  value: category,

                  isExpanded: true,

                  dropdownColor: Colors.black,

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
              width: double.infinity,

              padding: const EdgeInsets.all(15),

              decoration: BoxDecoration(
                color: Colors.white10,

                borderRadius: BorderRadius.circular(20),
              ),

              child: Row(
                children: [
                  const Icon(Icons.calendar_month, color: Colors.greenAccent),

                  const SizedBox(width: 10),

                  Text(
                    "${selectedMonth.month}/${selectedMonth.year}",

                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),

                  const Spacer(),

                  TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,

                        initialDate: selectedMonth,

                        firstDate: DateTime(2020),

                        lastDate: DateTime(2100),
                      );

                      if (picked != null) {
                        setState(() {
                          selectedMonth = picked;
                        });
                      }
                    },

                    child: const Text("Change"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 35),

            SizedBox(
              width: double.infinity,

              height: 55,

              child: ElevatedButton(
                onPressed: loading ? null : saveBudget,

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),

                child: loading
                    ? const CircularProgressIndicator(color: Colors.black)
                    : const Text(
                        "Save Budget",

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
}
