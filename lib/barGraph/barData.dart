import 'package:expense_tracker/barGraph/individual_bar.dart';

class BarData {
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;

  BarData({
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thurAmount,
    required this.friAmount,
    required this.satAmount,
  });

  List<IndividualBar> barData = [];

  void initializeBarData() {
    barData = [
      // sun
      IndividualBar(x: 0, y: sunAmount),
      // Mon
      IndividualBar(x: 0, y: monAmount),
      // Tuesday
      IndividualBar(x: 0, y: tueAmount),
      // Wednesday
      IndividualBar(x: 0, y: wedAmount),
      // Thursday
      IndividualBar(x: 0, y: thurAmount),
      // Friday
      IndividualBar(x: 0, y: friAmount),
      // Saturday
      IndividualBar(x: 0, y: satAmount),
    ];
  }
}
