import 'package:expense_tracker/barGraph/barData.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarGraph extends StatelessWidget {
  final double? maxY;
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;

  const MyBarGraph({
    super.key,
    required this.maxY,
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thurAmount,
    required this.friAmount,
    required this.satAmount,
  });

  @override
  Widget build(BuildContext context) {
    // Initialize the bar data
    BarData myBarData = BarData(
      sunAmount: sunAmount,
      monAmount: monAmount,
      tueAmount: tueAmount,
      wedAmount: wedAmount,
      thurAmount: thurAmount,
      friAmount: friAmount,
      satAmount: satAmount,
    );

    myBarData.initializeBarData();

    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(67, 34, 75, 1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: BarChart(
            BarChartData(
              maxY: maxY ?? 300, // Use provided maxY or default to 300
              minY: 0,
              titlesData: const FlTitlesData(
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: getBottomTitles,
                    reservedSize: 30,
                  ),
                ),
              ),
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
              barGroups: myBarData.barData
                  .map(
                    (data) => BarChartGroupData(
                      x: data.x,
                      barRods: [
                        BarChartRodData(
                          toY: data.y,
                          color: Colors.deepOrange,
                          width: 20,
                          borderRadius: BorderRadius.circular(7),
                          backDrawRodData: BackgroundBarChartRodData(
                            show: true,
                            color: Colors.black26,
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  Widget text;

  switch (value.toInt()) {
    case 0:
      text = const Text('Su', style: style); // Sunday
      break;
    case 1:
      text = const Text('M', style: style); // Monday
      break;
    case 2:
      text = const Text('T', style: style); // Tuesday
      break;
    case 3:
      text = const Text('W', style: style); // Wednesday
      break;
    case 4:
      text = const Text('Th', style: style); // Thursday
      break;
    case 5:
      text = const Text('F', style: style); // Friday
      break;
    case 6:
      text = const Text('Sa', style: style); // Saturday
      break;
    default:
      text = const Text('', style: style);
      break;
  }
  return text;
}
