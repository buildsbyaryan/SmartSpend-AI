import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/income_provider.dart';
import '../widgets/income_card.dart';
import 'add_income_screen.dart';

class IncomeHistoryScreen extends StatefulWidget {
  const IncomeHistoryScreen({super.key});

  @override
  State<IncomeHistoryScreen> createState() => _IncomeHistoryScreenState();
}

class _IncomeHistoryScreenState extends State<IncomeHistoryScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<IncomeProvider>().fetchIncome();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<IncomeProvider>();

    return Scaffold(
      backgroundColor: const Color(0xff050505),

      appBar: AppBar(
        backgroundColor: Colors.transparent,

        elevation: 0,

        centerTitle: true,

        title: const Text(
          "Income History 💰",

          style: TextStyle(color: Colors.white),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,

        child: const Icon(Icons.add, color: Colors.black),

        onPressed: () {
          Navigator.push(
            context,

            MaterialPageRoute(builder: (_) => const AddIncomeScreen()),
          );
        },
      ),

      body: provider.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.greenAccent),
            )
          : provider.incomeList.isEmpty
          ? const Center(
              child: Text(
                "No Income Added",

                style: TextStyle(color: Colors.white54, fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),

              itemCount: provider.incomeList.length,

              itemBuilder: (context, index) {
                final income = provider.incomeList[index];

                return Dismissible(
                  key: ValueKey(income.id),

                  direction: DismissDirection.endToStart,

                  confirmDismiss: (_) async {
                    return await showDialog(
                      context: context,

                      builder: (_) => AlertDialog(
                        backgroundColor: const Color(0xff1E293B),

                        title: const Text(
                          "Delete Income",

                          style: TextStyle(color: Colors.white),
                        ),

                        content: const Text(
                          "Are you sure you want to delete this income?",

                          style: TextStyle(color: Colors.white70),
                        ),

                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),

                            child: const Text("Cancel"),
                          ),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),

                            onPressed: () => Navigator.pop(context, true),

                            child: const Text("Delete"),
                          ),
                        ],
                      ),
                    );
                  },

                  onDismissed: (_) async {
                    final success = await provider.deleteIncome(income.id);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          success ? "Income Deleted" : "Delete Failed",
                        ),
                      ),
                    );
                  },

                  background: Container(
                    alignment: Alignment.centerRight,

                    padding: const EdgeInsets.only(right: 20),

                    decoration: BoxDecoration(
                      color: Colors.red,

                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: const Icon(Icons.delete, color: Colors.white),
                  ),

                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder: (_) => AddIncomeScreen(income: income),
                        ),
                      );
                    },

                    child: IncomeCard(income: income),
                  ),
                );
              },
            ),
    );
  }
}
