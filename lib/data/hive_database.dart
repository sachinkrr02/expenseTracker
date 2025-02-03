import 'package:hive_flutter/hive_flutter.dart';
import '../models/expense_item.dart';

class HiveDataBase {
  // Reference our Hive box
  final _myBox = Hive.box("expense_database");

  // Write data to Hive
  void saveData(List<ExpenseItem> allExpense) {
    List<List<dynamic>> allExpenseFormatted = [];

    for (var expense in allExpense) {
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime
            .toIso8601String(), // Convert DateTime to string before saving
        expense.category, // Ensure category is stored
      ];
      allExpenseFormatted.add(expenseFormatted);
    }

    // Store the formatted data in the database
    _myBox.put("ALL_EXPENSES", allExpenseFormatted);
  }

  // Read data from Hive
  List<ExpenseItem> readData() {
    List savedExpenses = _myBox.get("ALL_EXPENSES") ?? [];
    List<ExpenseItem> allExpenses = [];

    for (var expense in savedExpenses) {
      if (expense.length == 4) {
        // Ensure the data contains expected fields
        String name = expense[0];
        double amount = expense[1];
        DateTime dateTime =
            DateTime.parse(expense[2]); // Convert string back to DateTime
        String category = expense[3];

        ExpenseItem expenseItem = ExpenseItem(
          name: name,
          amount: amount,
          dateTime: dateTime,
          category: category,
        );

        allExpenses.add(expenseItem);
      } else {
        // Handle invalid or incomplete data
        print("Skipping invalid expense data: $expense");
      }
    }

    return allExpenses;
  }
}
