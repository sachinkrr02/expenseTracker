import 'package:expense_tracker/data/hive_database.dart';
import 'package:expense_tracker/dateTime/date_time_helper.dart';
import 'package:expense_tracker/models/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseData extends ChangeNotifier {
  // List of all expenses
  List<ExpenseItem> overallExpenseList = [];
  double weekyTotal = 0.0;
  double dailyTotal = 0.0;

  // Get expense list
  List<ExpenseItem> getAllExpenseList() {
    return overallExpenseList;
  }

  // Prepare data to display
  final db = HiveDataBase();
  void prepareData() {
    // If there exists data, get it
    final storedData = db.readData();
    if (storedData.isNotEmpty) {
      overallExpenseList = storedData;
    }
  }

  // Add new expense
  void addNewExpense(ExpenseItem newExpense) {
    overallExpenseList.add(newExpense);
    notifyListeners();
    db.saveData(overallExpenseList);
  }

  // Delete expense
  void deleteExpense(ExpenseItem expense) {
    overallExpenseList.remove(expense);
    notifyListeners();
    db.saveData(overallExpenseList);
  }

  // Get weekday name from a DateTime object
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday"; // Fixed capitalization
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      case 7:
        return "Sunday";
      default:
        return '';
    }
  }

  // Get the date for the start of the week (Sunday)
  DateTime startOfWeekDate() {
    DateTime today = DateTime.now();
    while (getDayName(today) != 'Sunday') {
      today = today.subtract(const Duration(days: 1));
    }
    return today;
  }

  // Convert overall list of expenses into a daily expense summary
  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {};

    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.tryParse(expense.amount.toString()) ?? 0.0;

      if (dailyExpenseSummary.containsKey(date)) {
        dailyExpenseSummary[date] = dailyExpenseSummary[date]! + amount;
      } else {
        dailyExpenseSummary[date] = amount;
      }
    }
    return dailyExpenseSummary;
  }

  Map<String, double> calculateMonthlyExpenseSummary(
      List<ExpenseItem> overallExpenseList) {
    Map<String, double> monthlyExpenseSummary = {};

    for (var expense in overallExpenseList) {
      String month =
          "${expense.dateTime.year}-${expense.dateTime.month.toString().padLeft(2, '0')}";
      double amount = double.tryParse(expense.amount.toString()) ?? 0.0;

      if (monthlyExpenseSummary.containsKey(month)) {
        monthlyExpenseSummary[month] = monthlyExpenseSummary[month]! + amount;
      } else {
        monthlyExpenseSummary[month] = amount;
      }
    }
    return monthlyExpenseSummary;
  }

  double caluclateWeekTotal(
    ExpenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ) {
    double? max = 100;

    List<double> values = [
      value.calculateDailyExpenseSummary()[sunday] ?? 0,
      value.calculateDailyExpenseSummary()[monday] ?? 0,
      value.calculateDailyExpenseSummary()[tuesday] ?? 0,
      value.calculateDailyExpenseSummary()[wednesday] ?? 0,
      value.calculateDailyExpenseSummary()[thursday] ?? 0,
      value.calculateDailyExpenseSummary()[friday] ?? 0,
      value.calculateDailyExpenseSummary()[saturday] ?? 0,
    ];

    double total = 0;
    for (int i = 0; i < values.length - 1; i++) {
      total += values[i];
    }
    return total;
  }
}

// calculate total expense
