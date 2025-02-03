// import 'package:expense_tracker/barGraph/bar_garph.dart';
// import 'package:expense_tracker/data/expense_data.dart';
// import 'package:expense_tracker/dateTime/date_time_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class ExpenseSummary extends StatelessWidget {
//   final DateTime startOfWeek;
//   const ExpenseSummary({
//     super.key,
//     required this.startOfWeek,
//   });

//   // calculate max amount in bar graph
//   double calculateMax(
//     ExpenseData value,
//     String sunday,
//     String monday,
//     String tuesday,
//     String wednesday,
//     String thursday,
//     String friday,
//     String saturday,
//   ) {
//     double? max = 100;

//     List<double> values = [
//       value.calculateDailyExpenseSummary()[sunday] ?? 0,
//       value.calculateDailyExpenseSummary()[monday] ?? 0,
//       value.calculateDailyExpenseSummary()[tuesday] ?? 0,
//       value.calculateDailyExpenseSummary()[wednesday] ?? 0,
//       value.calculateDailyExpenseSummary()[thursday] ?? 0,
//       value.calculateDailyExpenseSummary()[friday] ?? 0,
//       value.calculateDailyExpenseSummary()[saturday] ?? 0,
//     ];

//     // sort from smallest to largest
//     values.sort();

//     max = values.last * 1.1;

//     return max == 0 ? 100 : max;
//   }

//   // calculate the week total
//   String caluclateWeekTotal(
//     ExpenseData value,
//     String sunday,
//     String monday,
//     String tuesday,
//     String wednesday,
//     String thursday,
//     String friday,
//     String saturday,
//   ) {
//     double? max = 100;

//     List<double> values = [
//       value.calculateDailyExpenseSummary()[sunday] ?? 0,
//       value.calculateDailyExpenseSummary()[monday] ?? 0,
//       value.calculateDailyExpenseSummary()[tuesday] ?? 0,
//       value.calculateDailyExpenseSummary()[wednesday] ?? 0,
//       value.calculateDailyExpenseSummary()[thursday] ?? 0,
//       value.calculateDailyExpenseSummary()[friday] ?? 0,
//       value.calculateDailyExpenseSummary()[saturday] ?? 0,
//     ];

//     double total = 0;
//     for (int i = 0; i < values.length - 1; i++) {
//       total += values[i];
//     }
//     return total.toStringAsFixed(2);
//   }

//   @override
//   Widget build(BuildContext context) {
//     // get yymmdd for each day of this week
//     double width = MediaQuery.of(context).size.width;

//     String sunday =
//         convertDateTimeToString(startOfWeek.add(const Duration(days: 0)));
//     String monday =
//         convertDateTimeToString(startOfWeek.add(const Duration(days: 1)));
//     String tuesday =
//         convertDateTimeToString(startOfWeek.add(const Duration(days: 2)));
//     String wednesday =
//         convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
//     String thursday =
//         convertDateTimeToString(startOfWeek.add(const Duration(days: 4)));
//     String friday =
//         convertDateTimeToString(startOfWeek.add(const Duration(days: 5)));
//     String saturday =
//         convertDateTimeToString(startOfWeek.add(const Duration(days: 6)));

//     // Get today's date in the required format
//     String today = convertDateTimeToString(DateTime.now());

//     return Consumer<ExpenseData>(
//       builder: (context, value, child) => Column(
//         children: [
//           // bar graph
//           SizedBox(
//             height: 200,
//             child: MyBarGraph(
//               maxY: calculateMax(value, sunday, monday, tuesday, wednesday,
//                   thursday, friday, saturday),
//               sunAmount: value.calculateDailyExpenseSummary()[sunday] ?? 0,
//               monAmount: value.calculateDailyExpenseSummary()[monday] ?? 0,
//               tueAmount: value.calculateDailyExpenseSummary()[tuesday] ?? 0,
//               wedAmount: value.calculateDailyExpenseSummary()[wednesday] ?? 0,
//               thurAmount: value.calculateDailyExpenseSummary()[thursday] ?? 0,
//               friAmount: value.calculateDailyExpenseSummary()[friday] ?? 0,
//               satAmount: value.calculateDailyExpenseSummary()[saturday] ?? 0,
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),

//           // summary
//           Row(
//             children: [
//               DataWidget(
//                   width: width,
//                   sunday: sunday,
//                   monday: monday,
//                   tuesday: tuesday,
//                   wednesday: wednesday,
//                   thursday: thursday,
//                   friday: friday,
//                   saturday: saturday),
//               const SizedBox(
//                 width: 10,
//               ),
//               DataWidget2(
//                 width: width,
//                 today: today,
//                 text: value.calculateDailyExpenseSummary()[today] ?? 0,
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               DataWidget2(width: width, today: today , text: "value.calculateDailyExpenseSummary()[today] ?? 0",),
//             ],
//           ),

//           // const SizedBox(height: 20),
//           // Daily expenses display
//           // Row(
//           //   mainAxisAlignment: MainAxisAlignment.spaceAround,
//           //   children: [
//           //     _buildDayExpense(sunday, value, "Sun"),
//           //     _buildDayExpense(monday, value, "Mon"),
//           //     _buildDayExpense(tuesday, value, "Tue"),
//           //     _buildDayExpense(wednesday, value, "Wed"),
//           //     _buildDayExpense(thursday, value, "Thu"),
//           //     _buildDayExpense(friday, value, "Fri"),
//           //     _buildDayExpense(saturday, value, "Sat"),
//           //   ],
//           // ),
//         ],
//       ),
//     );
//   }

//   // Helper method to build daily expense widget
//   Widget _buildDayExpense(String day, ExpenseData value, String dayAbbr) {
//     double amount = value.calculateDailyExpenseSummary()[day] ?? 0;
//     return Column(
//       children: [
//         Text(
//           dayAbbr,
//           style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//         ),
//         Text(
//           '\u{20B9} ${amount.toStringAsFixed(2)}',
//           style: const TextStyle(fontSize: 14),
//         ),
//       ],
//     );
//   }
// }

// class DataWidget2 extends StatelessWidget {
//   const DataWidget2({
//     super.key,
//     required this.width,
//     required this.today,
//     required this.text,
//   });

//   final double width;
//   final String today;
//   final String text;

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ExpenseData>(builder: (context, value, _) {
//       return Container(
//         height: 100,
//         width: width * 0.29,
//         padding: const EdgeInsets.all(15),
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)], // Gradient effect
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.2),
//               blurRadius: 10,
//               spreadRadius: 2,
//               offset: const Offset(0, 5),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               "Daily",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             const SizedBox(height: 5),
//             Text(
//               '\u{20B9} $text',
//               style: const TextStyle(fontSize: 18, color: Colors.white),
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }

// class DataWidget extends StatelessWidget {
//   const DataWidget({
//     super.key,
//     required this.width,
//     required this.sunday,
//     required this.monday,
//     required this.tuesday,
//     required this.wednesday,
//     required this.thursday,
//     required this.friday,
//     required this.saturday,
//   });

//   final double width;
//   final String sunday;
//   final String monday;
//   final String tuesday;
//   final String wednesday;
//   final String thursday;
//   final String friday;
//   final String saturday;

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ExpenseData>(builder: (context, value, _) {
//       return Container(
//         height: 100,
//         width: width * 0.29,
//         padding: const EdgeInsets.all(15),
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)], // Gradient effect
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.2),
//               blurRadius: 10,
//               spreadRadius: 2,
//               offset: const Offset(0, 5),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               "Weekly",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             const SizedBox(height: 5),
//             Text(
//               '\u{20B9} ${value.caluclateWeekTotal(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday)}',
//               style: const TextStyle(fontSize: 18, color: Colors.white),
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }  