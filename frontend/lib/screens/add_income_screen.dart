import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/income_model.dart';
import '../providers/income_provider.dart';

class AddIncomeScreen extends StatefulWidget {
  final Income? income;

  const AddIncomeScreen({super.key, this.income});

  @override
  State<AddIncomeScreen> createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends State<AddIncomeScreen> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  String category = "Salary";

  final categories = ["Salary", "Business", "Freelance", "Investment", "Other"];

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    if (widget.income != null) {
      titleController.text = widget.income!.title;

      amountController.text = widget.income!.amount.toString();

      category = widget.income!.category;

      selectedDate = widget.income!.date;
    }
  }

  @override
  void dispose() {
    titleController.dispose();

    amountController.dispose();

    super.dispose();
  }

  Future<void> saveIncome() async {
    if (titleController.text.trim().isEmpty ||
        amountController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));

      return;
    }

    final income = Income(
      id: widget.income?.id ?? "",

      title: titleController.text.trim(),

      amount: double.parse(amountController.text.trim()),

      category: category,

      date: selectedDate,
    );

    final provider = context.read<IncomeProvider>();

    bool success;

    if (widget.income == null) {
      success = await provider.addIncome(income);
    } else {
      success = await provider.updateIncome(widget.income!.id, income);
    }

    if (success) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Operation Failed")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff050505),

      appBar: AppBar(
        backgroundColor: Colors.transparent,

        elevation: 0,

        centerTitle: true,

        title: Text(
          widget.income == null ? "Add Income 💰" : "Update Income ✏️",

          style: const TextStyle(color: Colors.white),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(
              controller: titleController,

              style: const TextStyle(color: Colors.white),

              decoration: inputDecoration("Income Name", Icons.title),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: amountController,

              keyboardType: TextInputType.number,

              style: const TextStyle(color: Colors.white),

              decoration: inputDecoration("Amount", Icons.currency_rupee),
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

                  dropdownColor: Colors.black,

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
                    "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",

                    style: const TextStyle(color: Colors.white),
                  ),

                  const Spacer(),

                  TextButton(
                    child: const Text("Change"),

                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,

                        initialDate: selectedDate,

                        firstDate: DateTime(2020),

                        lastDate: DateTime(2100),
                      );

                      if (picked != null) {
                        setState(() {
                          selectedDate = picked;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 35),

            SizedBox(
              width: double.infinity,

              height: 55,

              child: ElevatedButton(
                onPressed: saveIncome,

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),

                child: Text(
                  widget.income == null ? "Save Income" : "Update Income",

                  style: const TextStyle(
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

  InputDecoration inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,

      hintStyle: const TextStyle(color: Colors.white54),

      prefixIcon: Icon(icon, color: Colors.greenAccent),

      filled: true,

      fillColor: Colors.white10,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),

        borderSide: BorderSide.none,
      ),
    );
  }
}
