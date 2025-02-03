import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddExpenseDialog extends StatefulWidget {
  const AddExpenseDialog({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddExpenseDialogState createState() => _AddExpenseDialogState();
}

class _AddExpenseDialogState extends State<AddExpenseDialog> {
  final newExpenseAmountController = TextEditingController();
  final newExpenseNameController = TextEditingController();

  List<String> categories = [
    'Food',
    'Transport',
    'Entertainment',
    'Bills',
    'Other'
  ];
  String? selectedCategory; // Initialize as null

  // Save function (you should implement the save logic)
  void save() {
    if (newExpenseNameController.text.isNotEmpty &&
        newExpenseAmountController.text.isNotEmpty &&
        selectedCategory != null) {
      // Ensure category is selected
      try {
        ExpenseItem newExpense = ExpenseItem(
          name: newExpenseNameController.text,
          amount: double.parse(newExpenseAmountController.text),
          dateTime: DateTime.now(),
          category: selectedCategory!,
        );

        Provider.of<ExpenseData>(context, listen: false)
            .addNewExpense(newExpense);

        debugPrint(
            "New Expense - Name: ${newExpense.name}, Amount: ${newExpense.amount}, Category: ${newExpense.category}, Date: ${newExpense.dateTime}");

        Navigator.pop(context);
        clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please enter a valid amount"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Cancel action
  void cancel() {
    Navigator.pop(context);
    clear();
  }

  // Clear text fields
  void clear() {
    newExpenseAmountController.clear();
    newExpenseNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFFFAF9F6), // Softer light background
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25), // Smooth rounded corners
      ),
      title: const Row(
        children: [
          Icon(Icons.add_circle_outline, color: Color(0xFF5D3FD3), size: 28),
          SizedBox(width: 8),
          Text(
            "Add New Expense",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Color.fromRGBO(67, 34, 75, 1),
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Expense Amount Field
            TextField(
              controller: newExpenseAmountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Amount",
                hintText: "Enter amount",
                prefixIcon: const Icon(
                  Icons.attach_money,
                  color: Color.fromRGBO(67, 34, 75, 1),
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(67, 34, 75, 1), width: 2),
                ),
              ),
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(height: 12),

            // Expense Name Field
            TextField(
              controller: newExpenseNameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Expense Name",
                hintText: "e.g., Groceries, Transport",
                prefixIcon: const Icon(
                  Icons.edit,
                  color: Color.fromRGBO(67, 34, 75, 1),
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(67, 34, 75, 1), width: 2),
                ),
              ),
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(height: 12),

            // Expense Category Dropdown
            DropdownButtonFormField<String>(
              value: selectedCategory,
              onChanged: (newCategory) {
                setState(() {
                  selectedCategory = newCategory;
                });
              },
              decoration: InputDecoration(
                labelText: "Category",
                prefixIcon: const Icon(
                  Icons.category,
                  color: Color.fromRGBO(67, 34, 75, 1),
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(67, 34, 75, 1), width: 2),
                ),
              ),
              items: categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(
                    category,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton.icon(
              onPressed: save,
              icon: const Icon(Icons.save, color: Colors.white),
              label: const Text(
                'Save',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color.fromRGBO(67, 34, 75, 1), // Green Accent
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 4,
              ),
            ),
            // Spacer(),

            TextButton(
              onPressed: cancel,
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
