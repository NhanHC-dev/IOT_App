import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class TemperatureChart extends StatelessWidget {
  final List<dynamic> data;
  final double maxTempFixed;
  final double minTempFixed;

  TemperatureChart({
    required this.data,
    required this.maxTempFixed,
    required this.minTempFixed,
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
              color: Colors.blue,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
          ],
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
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
      return FlSpot(item['x'].toDouble(), item['y'].toDouble());
    }).toList();
  }
}
