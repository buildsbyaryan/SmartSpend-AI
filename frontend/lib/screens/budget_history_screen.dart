import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/budget_provider.dart';
import 'add_budget_screen.dart';

class BudgetHistoryScreen extends StatefulWidget {
  const BudgetHistoryScreen({super.key});

  @override
  State<BudgetHistoryScreen> createState() => _BudgetHistoryScreenState();
}

class _BudgetHistoryScreenState extends State<BudgetHistoryScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<BudgetProvider>().fetchBudget();
    });
  }

  Future<void> openAddBudget() async {
    await Navigator.push(
      context,

      MaterialPageRoute(builder: (_) => const AddBudgetScreen()),
    );

    if (!mounted) return;

    context.read<BudgetProvider>().fetchBudget();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BudgetProvider>();

    return Scaffold(
      backgroundColor: const Color(0xff050505),

      appBar: AppBar(
        backgroundColor: Colors.transparent,

        elevation: 0,

        centerTitle: true,

        title: const Text(
          "Budget 💰",

          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,

        child: const Icon(Icons.add, color: Colors.black),

        onPressed: openAddBudget,
      ),

      body: provider.loading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.greenAccent),
            )
          : provider.budget == null
          ? const Center(
              child: Text(
                "No Budget Added",

                style: TextStyle(color: Colors.white54, fontSize: 18),
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),

              child: Container(
                padding: const EdgeInsets.all(22),

                decoration: BoxDecoration(
                  color: Colors.white10,

                  borderRadius: BorderRadius.circular(25),

                  border: Border.all(color: Colors.greenAccent.withOpacity(.3)),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        const Text(
                          "Budget",

                          style: TextStyle(
                            color: Colors.white,

                            fontSize: 22,

                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        IconButton(
                          icon: const Icon(
                            Icons.delete,

                            color: Colors.redAccent,
                          ),

                          onPressed: () async {
                            final confirm = await showDialog<bool>(
                              context: context,

                              builder: (context) => AlertDialog(
                                backgroundColor: const Color(0xff1E293B),

                                title: const Text(
                                  "Delete Budget",

                                  style: TextStyle(color: Colors.white),
                                ),

                                content: const Text(
                                  "Are you sure?",

                                  style: TextStyle(color: Colors.white70),
                                ),

                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),

                                    child: const Text("Cancel"),
                                  ),

                                  ElevatedButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),

                                    child: const Text("Delete"),
                                  ),
                                ],
                              ),
                            );

                            if (confirm == true) {
                              final result = await provider.deleteBudget(
                                provider.budget!.id!,
                              );

                              if (!mounted) return;

                              if (result) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Budget Deleted"),
                                  ),
                                );
                              }
                            }
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      "Monthly Limit",

                      style: TextStyle(color: Colors.white54, fontSize: 15),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "₹ ${provider.budget!.limit.toStringAsFixed(0)}",

                      style: const TextStyle(
                        color: Colors.greenAccent,

                        fontSize: 32,

                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_month,

                          color: Colors.greenAccent,
                        ),

                        const SizedBox(width: 10),

                        Text(
                          "Month : ${provider.budget!.month}/${provider.budget!.year}",

                          style: const TextStyle(
                            color: Colors.white70,

                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
