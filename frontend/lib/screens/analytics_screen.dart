import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_spend_ai/widgets/ai_savings_card.dart';
import 'package:smart_spend_ai/widgets/calendar_heatmap_card.dart';
import 'package:smart_spend_ai/widgets/financial_health_card.dart';
import 'package:smart_spend_ai/widgets/monthly_prediction_card.dart';
import '../widgets/monthly_line_chart.dart';
import '../providers/expense_provider.dart';
import '../widgets/futuristic_card.dart';
import '../widgets/pie_chart_card.dart';
import '../widgets/weekly_bar_chart.dart';
import '../widgets/spending_score_card.dart';
import '../services/pdf_service.dart';
import '../widgets/date_filter.dart';
import '../widgets/top_expenses_card.dart';
import '../widgets/highest_spending_day_card.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();

    return Scaffold(
      backgroundColor: const Color(0xff050505),

      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf, color: Colors.redAccent),

            onPressed: () async {
              await PdfService.generateReport(provider.expenses);
            },
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "AI Analytics 🤖",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            /// HEADER
            const Text(
              "📊 Expense Analytics",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              "Track spending trends, category distribution and AI powered insights.",
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 15,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 25),
            const DateFilter(),

            const SizedBox(height: 25),

            /// TOTAL SPENDING
            FuturisticCard(
              title: "Total Spending",
              value: "₹${provider.analyticsTotalExpense.toStringAsFixed(2)}",
              icon: Icons.account_balance_wallet,
            ),

            const SizedBox(height: 18),

            /// TRANSACTIONS
            FuturisticCard(
              title: "Total Transactions",
              value: provider.analyticsTransactions.toString(),
              icon: Icons.receipt_long,
            ),

            const SizedBox(height: 18),

            /// AVERAGE
            FuturisticCard(
              title: "Average Expense",
              value: "₹${provider.analyticsAverageExpense.toStringAsFixed(2)}",
              icon: Icons.analytics,
            ),

            const SizedBox(height: 30),

            /// PIE CHART
            provider.expenses.isEmpty
                ? Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Column(
                      children: [
                        Icon(Icons.pie_chart, color: Colors.white30, size: 60),
                        SizedBox(height: 15),
                        Text(
                          "No Analytics Available",
                          style: TextStyle(color: Colors.white54, fontSize: 16),
                        ),
                      ],
                    ),
                  )
                : const PieChartCard(),
            const SizedBox(height: 30),

            const MonthlyLineChart(),

            const SizedBox(height: 30),

            const WeeklyBarChart(),

            const SizedBox(height: 30),

            const SpendingScoreCard(),

            const SizedBox(height: 30),

            const MonthlyPredictionCard(),

            const SizedBox(height: 30),

            const CalendarHeatmapCard(),

            const SizedBox(height: 30),

            const HighestSpendingDayCard(),

            const SizedBox(height: 30),

            const TopExpensesCard(),

            const SizedBox(height: 30),

            const AiSavingsCard(),

            const SizedBox(height: 30),

            const FinancialHealthCard(),

            const SizedBox(height: 30),

            /// QUICK SUMMARY
            const Text(
              "Quick Summary",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xff111827), Color(0xff1E293B)],
                ),

                borderRadius: BorderRadius.circular(22),

                border: Border.all(color: Colors.cyanAccent.withOpacity(.3)),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "🏆 Highest Category : ${provider.analyticsHighestCategory}",
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    "💳 Total Transactions : ${provider.analyticsTransactions}",
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    "💸 Average Expense : ₹${provider.analyticsAverageExpense.toStringAsFixed(0)}",
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    "📅 This Month : ₹${provider.thisMonthExpense.toStringAsFixed(0)}",
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const TopExpensesCard(),

            const SizedBox(height: 30),

            const HighestSpendingDayCard(),
            const SizedBox(height: 30),

            /// AI INSIGHTS
            Row(
              children: const [
                Icon(Icons.psychology, color: Colors.cyanAccent),

                SizedBox(width: 10),

                Text(
                  "AI Insights",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),

              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xff111827), Color(0xff1E293B)],
                ),

                borderRadius: BorderRadius.circular(22),

                border: Border.all(color: Colors.cyanAccent.withOpacity(.4)),

                boxShadow: [
                  BoxShadow(
                    color: Colors.cyanAccent.withOpacity(.15),
                    blurRadius: 18,
                  ),
                ],
              ),

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.auto_awesome,
                    color: Colors.cyanAccent,
                    size: 34,
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: Text(
                      getInsight(provider),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  String getInsight(ExpenseProvider provider) {
    if (provider.expenses.isEmpty) {
      return "🤖 Add some expenses first to unlock AI-powered analytics and spending insights.";
    }

    if (provider.analyticsTotalExpense > provider.monthlyBudget &&
        provider.monthlyBudget > 0) {
      return "🚨 You have exceeded your monthly budget. Consider reducing discretionary spending.";
    }

    if (provider.analyticsTotalExpense > 10000) {
      return "⚠️ Your spending is high this month. Focus on saving more and reviewing unnecessary expenses.";
    }

    if (provider.analyticsHighestCategory == "Food") {
      return "🍔 Most of your money goes toward Food. Cooking at home more often could help reduce expenses.";
    }

    if (provider.analyticsHighestCategory == "Shopping") {
      return "🛍 Shopping is your highest spending category. Review your purchases and prioritize essentials.";
    }

    return "✅ Great job! Your spending is under control. Keep tracking your expenses consistently.";
  }
}
