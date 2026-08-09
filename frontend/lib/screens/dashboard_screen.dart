import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_spend_ai/providers/budget_provider.dart';
import 'package:smart_spend_ai/screens/add_budget_screen.dart';
import 'package:smart_spend_ai/screens/analytics_screen.dart';
import 'package:smart_spend_ai/screens/login_screen.dart';
import 'package:smart_spend_ai/services/auth_service.dart';
import 'package:smart_spend_ai/utils/page_transition.dart';
import '../widgets/search_expense_bar.dart';
import '../providers/expense_provider.dart';
import '../widgets/futuristic_card.dart';
import '../widgets/ai_card.dart';
import '../widgets/category_card.dart';
import '../widgets/expense_tile.dart';
import 'add_expense_screen.dart';
import '../ai/ai_analyzer.dart';
import '../widgets/category_filter.dart';
import '../widgets/sort_button.dart';
import '../widgets/stat_card.dart';
import '../widgets/insight_card.dart';
import '../widgets/budget_card.dart';
import '../providers/income_provider.dart';
import 'income_history_screen.dart';
import 'add_income_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<ExpenseProvider>().loadData();
      context.read<BudgetProvider>().fetchBudget();
    });
  }

  @override
  Widget build(BuildContext context) {
    final expenseProvider = context.watch<ExpenseProvider>();

    final incomeProvider = context.watch<IncomeProvider>();

    final budgetProvider = context.watch<BudgetProvider>();

    final provider = context.watch<ExpenseProvider>();

    return Scaffold(
      backgroundColor: const Color(0xff050505),

      appBar: AppBar(
        backgroundColor: Colors.transparent,

        elevation: 0,

        title: const Text(
          "SmartSpend AI 🤖",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),

        centerTitle: true,

        actions: [
          IconButton(
            icon: const Icon(Icons.analytics, color: Colors.cyanAccent),

            onPressed: () {
              Navigator.push(
                context,
                PageTransition.slide(const AnalyticsScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_balance, color: Colors.greenAccent),
            onPressed: () {
              Navigator.push(
                context,
                PageTransition.slide(IncomeHistoryScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            onPressed: () async {
              await AuthService.logout();

              if (!context.mounted) return;

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyanAccent,
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) => SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.remove_circle_outline),
                    title: const Text("Add Expense"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        PageTransition.slide(AddExpenseScreen()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.add_circle_outline),
                    title: const Text("Add Income"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        PageTransition.slide(AddIncomeScreen()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.account_balance_wallet),

                    title: const Text("Set Budget"),

                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,

                        PageTransition.slide(const AddBudgetScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              "👋 Welcome Back",
              style: TextStyle(color: Colors.white60, fontSize: 16),
            ),

            const SizedBox(height: 6),

            FuturisticCard(
              title: "Total Balance",
              value:
                  "₹${(incomeProvider.totalIncome - expenseProvider.totalExpense).toStringAsFixed(2)}",
              icon: Icons.account_balance,
            ),

            const SizedBox(height: 20),

            FuturisticCard(
              title: "Total Income",
              value: "₹${incomeProvider.totalIncome.toStringAsFixed(2)}",
              icon: Icons.arrow_downward,
            ),
            const SizedBox(height: 20),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: FuturisticCard(
                title: "Total Expense",
                value: "₹${provider.totalExpense.toStringAsFixed(2)}",
                icon: Icons.account_balance_wallet,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "SmartSpend AI Dashboard",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              "Track every rupee with AI insights.",
              style: TextStyle(color: Colors.grey.shade400, fontSize: 15),
            ),

            const SizedBox(height: 10),

            const Text(
              "Overview",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                StatCard(
                  title: "Transactions",
                  value: provider.totalTransactions.toString(),
                  icon: Icons.receipt_long,
                  color: Colors.orange,
                ),

                StatCard(
                  title: "Average",
                  value: "₹${provider.averageExpense.toStringAsFixed(0)}",
                  icon: Icons.bar_chart,
                  color: Colors.green,
                ),
              ],
            ),

            Row(
              children: [
                StatCard(
                  title: "Top Category",
                  value: provider.getHighestCategory(),
                  icon: Icons.star,
                  color: Colors.cyanAccent,
                ),

                StatCard(
                  title: "Status",
                  value: provider.totalExpense > 10000 ? "High" : "Good",
                  icon: Icons.auto_graph,
                  color: provider.totalExpense > 10000
                      ? Colors.redAccent
                      : Colors.lightGreenAccent,
                ),
              ],
            ),

            const SizedBox(height: 20),

            AiCard(message: AIAnalyzer.getSuggestion(provider.expenses)),

            const SizedBox(height: 20),

            BudgetCard(
              budget: budgetProvider.budget,
              expense: expenseProvider.totalExpense,
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                const Expanded(child: SearchExpenseBar()),

                const SizedBox(width: 12),

                const SortButton(),
              ],
            ),

            const SizedBox(height: 20),

            const CategoryFilter(),
            const SizedBox(height: 30),

            const Text(
              "Expense Categories",

              style: TextStyle(
                color: Colors.white,

                fontSize: 22,

                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              height: 160,

              child: ListView(
                scrollDirection: Axis.horizontal,

                children: [
                  CategoryCard(
                    title: "Food",

                    amount: provider.getCategoryAmount("Food"),

                    icon: Icons.restaurant,
                  ),

                  const SizedBox(width: 15),

                  CategoryCard(
                    title: "Travel",

                    amount: provider.getCategoryAmount("Travel"),

                    icon: Icons.flight,
                  ),

                  const SizedBox(width: 15),

                  CategoryCard(
                    title: "Shopping",

                    amount: provider.getCategoryAmount("Shopping"),

                    icon: Icons.shopping_bag,
                  ),

                  const SizedBox(width: 15),

                  CategoryCard(
                    title: "Bills",

                    amount: provider.getCategoryAmount("Bills"),

                    icon: Icons.receipt,
                  ),

                  const SizedBox(width: 15),

                  CategoryCard(
                    title: "Health",
                    amount: provider.getCategoryAmount("Health"),
                    icon: Icons.health_and_safety,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "📈 Spending Insights",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 18),

            InsightCard(
              title: "Highest Expense",
              value: "₹${provider.highestExpense.toStringAsFixed(0)}",
              icon: Icons.local_fire_department,
              color: Colors.redAccent,
            ),

            InsightCard(
              title: "This Month",
              value: "₹${provider.thisMonthExpense.toStringAsFixed(0)}",
              icon: Icons.calendar_month,
              color: Colors.cyanAccent,
            ),

            InsightCard(
              title: "This Week",
              value: "₹${provider.thisWeekExpense.toStringAsFixed(0)}",
              icon: Icons.date_range,
              color: Colors.greenAccent,
            ),
            const SizedBox(height: 30),
            const Text(
              "Recent Expenses",

              style: TextStyle(
                color: Colors.white,

                fontSize: 22,

                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            provider.filteredExpenses.isEmpty
                ? const Column(
                    children: [
                      Icon(Icons.receipt_long, color: Colors.white30, size: 70),

                      SizedBox(height: 15),

                      Text(
                        "No Expenses Yet",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 8),

                      Text(
                        "Tap the + button to add your first expense.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white54),
                      ),
                    ],
                  )
                : ListView.builder(
                    shrinkWrap: true,

                    physics: const NeverScrollableScrollPhysics(),

                    itemCount: provider.filteredExpenses.length,
                    itemBuilder: (context, index) {
                      return ExpenseTile(
                        expense: provider.filteredExpenses[index],

                        index: index,
                      );
                    },
                  ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
