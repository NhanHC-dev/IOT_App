import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HumidityChart extends StatelessWidget {
  final List<dynamic> data;
  final double maxHumidity;
  final double minHumidity;

  HumidityChart({
    required this.data,
    required this.maxHumidity,
    required this.minHumidity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: _convertDataToFlSpots(data),
              isCurved: true,
              color: Colors.blue, // Use color here
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
          ],
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(
              color: const Color(0xff37434d),
              width: 1,
            ),
          ),
        ),
      ),
    );
  }

  List<FlSpot> _convertDataToFlSpots(List<dynamic> data) {
    return data.map<FlSpot>((item) {
      // Replace this with your actual data conversion logic
      return FlSpot(item['x'].toDouble(), item['y'].toDouble());
    }).toList();
  }
}
