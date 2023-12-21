import 'package:hive_flutter/hive_flutter.dart';
import 'package:expense_tracker/main.dart';
import '../models/expense_item.dart';

class HiveDataBase {
  // reference our box
  final _myBox = Hive.box("expense_database");

  //write data
  void saveData(List<ExpenseItem> allExpense) {
    /*

    Hive can only store strings and dateTime , and not custom objects like ExpenseItem.
    So lets convert ExpenseItem objects into types that can be stored in oue db.
  
[
  allExpense(name/amount/datetime)
  ..
]

->
[name,amount,datetime],


*/

    List<List<dynamic>> allExpenseFormatted = [];

    for (var expense in allExpense) {
      List<dynamic> expenseFomatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
      ];
      allExpenseFormatted.add(expenseFomatted);
    }

    //finally lets store in our database
    _myBox.put("ALL_EXPENSES", allExpenseFormatted);
    //print(_myBox.get(1));
  }

  //read data
  List<ExpenseItem> readData() {
/* 
Data is stored in Hive as a list of string + dateTime
so lets convert our saved data into ExpenseItem objects

savedData = 

[
  name,amount,dateTime
],

-> [
ExpenseItem(name / amount / dateTime),

.. 

]
*/

    List savedExpenses = _myBox.get("ALL_EXPENSES") ?? [];
    List<ExpenseItem> allExpenses = [];

    for (int i = 0; i < savedExpenses.length; i++) {
      // collect individual expense data

      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];

      // create expense item

      ExpenseItem expense = ExpenseItem(
        name: name,
        amount: amount,
        dateTime: dateTime,
      );

      // add expense to overall list of expenses
      allExpenses.add(expense);
    }

    return allExpenses;
  }
}
