import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  final String category; // New category parameter
  final void Function(BuildContext)? deleteTapped;

  ExpenseTile({
    super.key,
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.category,
    required this.deleteTapped,
  });

  // Map of categories to corresponding icons
  Icon _getCategoryIcon(String category) {
    switch (category) {
      case 'Food':
        return Icon(Icons.fastfood, color: Colors.orange);
      case 'Transport':
        return Icon(Icons.directions_car, color: Colors.blue);
      case 'Entertainment':
        return Icon(Icons.movie, color: Colors.purple);
      case 'Bills':
        return Icon(Icons.payment, color: Colors.green);
      case 'Other':
      default:
        return Icon(Icons.category, color: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          // delete button
          SlidableAction(
            onPressed: deleteTapped,
            icon: Icons.delete,
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
            borderRadius: BorderRadius.circular(12),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        leading: _getCategoryIcon(category),
        title: Text(
          name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          '${dateTime.day}/${dateTime.month}/${dateTime.year}',
          style: const TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
        ),
        trailing: Text(
          '\u{20B9} $amount',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
