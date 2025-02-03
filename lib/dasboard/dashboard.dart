import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/models/expense_item.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // For date formatting

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  List<ChartData> _getCategoryChartData(List<ExpenseItem> expenses) {
    Map<String, double> categoryData = {};

    for (var expense in expenses) {
      categoryData.update(
        expense.category,
        (value) => value + expense.amount,
        ifAbsent: () => expense.amount,
      );
    }

    return categoryData.entries.map((entry) {
      return ChartData(entry.key, entry.value, _getCategoryColor(entry.key));
    }).toList();
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Food':
        return const Color(0xFFE94E77); // Pinkish-Red
      case 'Transport':
        return const Color(0xFF547AA5); // Blue
      case 'Entertainment':
        return const Color(0xFF9B59B6); // Purple
      case 'Bills':
        return const Color(0xFF26A69A); // Teal
      case 'Other':
      default:
        return const Color(0xFF95A5A6); // Grey
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, expenseData, child) {
        List<ExpenseItem> currentMonthExpenses =
            expenseData.getAllExpenseList();

        double totalMonthExpense = currentMonthExpenses.fold(0, (sum, expense) {
          return sum + expense.amount;
        });

        double averageExpense = currentMonthExpenses.isNotEmpty
            ? totalMonthExpense / currentMonthExpenses.length
            : 0;

        // 📅 Daily Average Calculation
        DateTime today = DateTime.now();
        List<ExpenseItem> todayExpenses = currentMonthExpenses.where((expense) {
          return DateFormat('yyyy-MM-dd').format(expense.dateTime) ==
              DateFormat('yyyy-MM-dd').format(today);
        }).toList();

        double todayTotalExpense = todayExpenses.fold(0, (sum, expense) {
          return sum + expense.amount;
        });

        double dailyAverage = todayExpenses.isNotEmpty
            ? todayTotalExpense / todayExpenses.length
            : 0;

        return Scaffold(
          backgroundColor: const Color(0xFFF7F7F9),
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(67, 34, 75, 1),
            elevation: 0,
            title: const Text(
              "Expensi Dashboard",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_none, color: Colors.white),
                onPressed: () {
                  // Handle notifications action
                },
              ),
            ],
            leading: IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                // Handle menu action
              },
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle(Icons.pie_chart, 'Category-wise Breakdown'),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: SizedBox(
                    height: 350,
                    child: SfCircularChart(
                      series: <CircularSeries>[
                        PieSeries<ChartData, String>(
                          radius: '130',
                          dataSource:
                              _getCategoryChartData(currentMonthExpenses),
                          xValueMapper: (ChartData data, _) => data.category,
                          yValueMapper: (ChartData data, _) => data.amount,
                          pointColorMapper: (ChartData data, _) => data.color,
                          dataLabelMapper: (ChartData data, _) =>
                              '${data.category}: ₹${data.amount.toStringAsFixed(0)}',
                          dataLabelSettings: const DataLabelSettings(
                            isVisible: true,
                            textStyle: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          enableTooltip: true,
                        ),
                      ],
                      tooltipBehavior: TooltipBehavior(enable: true),
                      legend: const Legend(
                        isVisible: true,
                        position: LegendPosition.bottom,
                        alignment: ChartAlignment.center,
                      ),
                    ),
                  ),
                ),
                //daily expense
                const SizedBox(height: 25),
                _buildSectionTitle(Icons.today, 'Daily Average Expense'),
                const SizedBox(height: 10),
                _buildInfoCard(
                  title:
                      "Today's Total: ₹${todayTotalExpense.toStringAsFixed(2)}",
                  subtitle:
                      "Daily Average: ₹${dailyAverage.toStringAsFixed(2)}",
                  icon: Icons.trending_up,
                  bgColor: const Color(0xFF26A69A),
                ),
                // monthly expesni
                const SizedBox(height: 25),
                _buildSectionTitle(Icons.bar_chart, 'Monthly Expense Summary'),
                const SizedBox(height: 10),
                _buildInfoCard(
                  title:
                      'Total Expenses: ₹${totalMonthExpense.toStringAsFixed(2)}',
                  subtitle:
                      'Average Daily Expense: ₹${averageExpense.toStringAsFixed(2)}',
                  icon: Icons.calendar_month,
                  bgColor: const Color(0xFF5D3FD3),
                ),
                // all time expense
                const SizedBox(height: 25),
                _buildSectionTitle(Icons.attach_money, 'All-Time Expenses'),
                const SizedBox(height: 10),
                _buildInfoCard(
                  title: "Total Expenses So Far",
                  subtitle: "₹76,444",
                  icon: Icons.trending_up,
                  bgColor: const Color(0xFFE94E77),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF5D3FD3), size: 26),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color bgColor,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(icon, color: bgColor, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  final String category;
  final double amount;
  final Color color;

  ChartData(this.category, this.amount, this.color);
}
