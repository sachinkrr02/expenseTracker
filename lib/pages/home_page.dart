import 'package:expense_tracker/dasboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker/components/add_new_expense.dart';
import 'package:expense_tracker/components/expense_summary.dart';
import 'package:expense_tracker/components/expense_tile.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/models/expense_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Text controllers
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();
  final newExpenseCategoryController = TextEditingController();
  List<String> categories = [
    'Food',
    'Transport',
    'Entertainment',
    'Bills',
    'Other'
  ];
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    // Prepare data on startup
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  // Delete an expense
  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromRGBO(67, 34, 75, 1),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => const AddExpenseDialog());
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(67, 34, 75, 1),
          elevation: 0,
          title: const Text(
            "Expensi",
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
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: [
                // Weekly summary
                // Container(
                //   padding: const EdgeInsets.fromLTRB(
                //       30, 30, 0, 0), // Increased top padding for balance
                //   alignment: Alignment.topLeft,
                //   decoration: BoxDecoration(
                //     gradient: LinearGradient(
                //       colors: [Colors.purple.shade100, Colors.orange.shade100],
                //       begin: Alignment.topLeft,
                //       end: Alignment.bottomRight,
                //     ),
                //     borderRadius: BorderRadius.only(
                //       bottomRight: Radius.circular(30),
                //     ),
                //   ),
                //   child: const Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         "Hi! 👋",
                //         style: TextStyle(
                //           fontSize: 40,
                //           fontWeight: FontWeight.bold,
                //           color: Colors.white,
                //           fontFamily: 'Roboto', // More modern font style
                //         ),
                //       ),
                //       SizedBox(height: 5), // Spacing between the texts
                //       Text(
                //         "Your Daily Expense",
                //         style: TextStyle(
                //           fontSize: 28,
                //           fontWeight: FontWeight
                //               .w600, // Slightly lighter weight for variety
                //           color: Colors.white,
                //           fontFamily: 'Roboto', // Matching font
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                ExpenseSummary(startOfWeek: value.startOfWeekDate()),
                const SizedBox(height: 20),
                // Header text with gradient background

                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromRGBO(67, 34, 75, 1),
                        Color.fromRGBO(67, 34, 75, 1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Transactions',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                Container(
                  margin: const EdgeInsets.all(5),
                  // padding: const EdgeInsets.fromLTRB(0, 10, 0, 12),
                  decoration: BoxDecoration(
                    // color: const Color.fromRGBO(239, 135, 103, 0.1),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      value.getAllExpenseList().isEmpty
                          ? const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Text(
                                "No expenses added yet!",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            )
                          : ListView.builder(
                              reverse: true,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: value.getAllExpenseList().length,
                              itemBuilder: (context, index) => ExpenseTile(
                                name: value.getAllExpenseList()[index].name,
                                amount: value
                                    .getAllExpenseList()[index]
                                    .amount
                                    .toString(),
                                dateTime:
                                    value.getAllExpenseList()[index].dateTime,
                                category:
                                    value.getAllExpenseList()[index].category,
                                deleteTapped: (p0) => deleteExpense(
                                    value.getAllExpenseList()[index]),
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
