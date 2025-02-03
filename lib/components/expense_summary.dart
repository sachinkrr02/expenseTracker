import 'package:expense_tracker/barGraph/bar_garph.dart';
import 'package:expense_tracker/dasboard/dashboard.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/dateTime/date_time_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const ExpenseSummary({
    super.key,
    required this.startOfWeek,
  });

  // Calculate max amount for the bar graph
  double calculateMax(
    ExpenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ) {
    List<double> values = [
      value.calculateDailyExpenseSummary()[sunday] ?? 0.0,
      value.calculateDailyExpenseSummary()[monday] ?? 0.0,
      value.calculateDailyExpenseSummary()[tuesday] ?? 0.0,
      value.calculateDailyExpenseSummary()[wednesday] ?? 0.0,
      value.calculateDailyExpenseSummary()[thursday] ?? 0.0,
      value.calculateDailyExpenseSummary()[friday] ?? 0.0,
      value.calculateDailyExpenseSummary()[saturday] ?? 0.0,
    ];

    // Sort from smallest to largest
    values.sort();
    double max = values.last * 1.1;
    return max == 0 ? 100 : max;
  }

  // Calculate the total weekly expenses
  String calculateWeekTotal(
    ExpenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ) {
    List<double> values = [
      value.calculateDailyExpenseSummary()[sunday] ?? 0.0,
      value.calculateDailyExpenseSummary()[monday] ?? 0.0,
      value.calculateDailyExpenseSummary()[tuesday] ?? 0.0,
      value.calculateDailyExpenseSummary()[wednesday] ?? 0.0,
      value.calculateDailyExpenseSummary()[thursday] ?? 0.0,
      value.calculateDailyExpenseSummary()[friday] ?? 0.0,
      value.calculateDailyExpenseSummary()[saturday] ?? 0.0,
    ];

    double total = values.fold(0.0, (sum, element) => sum + element);
    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    // Get formatted date strings for each day of the week
    String sunday = convertDateTimeToString(startOfWeek);
    String monday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 1)));
    String tuesday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 2)));
    String wednesday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
    String thursday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 4)));
    String friday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 5)));
    String saturday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 6)));

    // Get today's date in the required format
    String today = convertDateTimeToString(DateTime.now());

    return Consumer<ExpenseData>(
      builder: (context, value, child) => Column(
        children: [
          // Bar graph
          SizedBox(
            height: 200,
            child: MyBarGraph(
              maxY: calculateMax(value, sunday, monday, tuesday, wednesday,
                  thursday, friday, saturday),
              sunAmount: value.calculateDailyExpenseSummary()[sunday] ?? 0,
              monAmount: value.calculateDailyExpenseSummary()[monday] ?? 0,
              tueAmount: value.calculateDailyExpenseSummary()[tuesday] ?? 0,
              wedAmount: value.calculateDailyExpenseSummary()[wednesday] ?? 0,
              thurAmount: value.calculateDailyExpenseSummary()[thursday] ?? 0,
              friAmount: value.calculateDailyExpenseSummary()[friday] ?? 0,
              satAmount: value.calculateDailyExpenseSummary()[saturday] ?? 0,
            ),
          ),
          const SizedBox(height: 10),

          // Summary section
          Row(
            children: [
              DataWidget(
                dataname: "Daily",
                width: width,
                today: today,
                text: value
                        .calculateDailyExpenseSummary()[today]
                        ?.toStringAsFixed(2) ??
                    '0.00',
              ),
              const SizedBox(width: 9),
              DataWidget(
                dataname: "Weekly",
                width: width,
                sunday: sunday,
                monday: monday,
                tuesday: tuesday,
                wednesday: wednesday,
                thursday: thursday,
                friday: friday,
                saturday: saturday,
                text: value
                    .caluclateWeekTotal(value, sunday, monday, tuesday,
                        wednesday, thursday, friday, saturday)
                    .toString(),
              ),
              const SizedBox(width: 9),
              DataWidget(
                dataname: "Monthly",
                width: width,
                today: today,
                text: value
                        .calculateDailyExpenseSummary()[today]
                        ?.toStringAsFixed(2) ??
                    '0.00',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DataWidget extends StatelessWidget {
  const DataWidget({
    super.key,
    required this.width,
    this.sunday,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.today,
    this.text,
    required this.dataname,
  });

  final double width;
  final String? sunday;
  final String? monday;
  final String? tuesday;
  final String? wednesday;
  final String? thursday;
  final String? friday;
  final String? saturday;
  final String? today;
  final String? text;
  final String dataname;

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(builder: (context, value, _) {
      return InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const DashboardPage()));
        },
        child: Container(
          height: 90,
          width: width * 0.30,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 20,
                spreadRadius: 2,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon or visual representation

              Text(
                dataname,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              // const Spacer(),
              const SizedBox(
                height: 10,
              ),
              Text(
                '\u{20B9} ${text ?? "0.00"}', // Fallback to "0.00" if text is null
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
