import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:iot_app/charts/legend.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoistureChart extends StatefulWidget {
  const MoistureChart({super.key});

  @override
  State<MoistureChart> createState() => _MoistureChartState();
}

class _MoistureChartState extends State<MoistureChart> {
  late double _minMoisture = 3.0;
  late double _maxMoisture = 37.0;

  late List<Map<String, dynamic>> data = [];
  final Random random = Random();

  Future<void> getTemperatureFromDevice() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve stored values or set default values if not available
    double minMoisture =
        prefs.getDouble('minMoisture') ?? 3.0; // Default min temperature 3°C
    double maxMoisture =
        prefs.getDouble('maxMoisture') ?? 37.0; // Default max temperature 37°C

    setState(() {
      _minMoisture = minMoisture * 100; // Convert to range used in Slider
      _maxMoisture = maxMoisture * 100; // Convert to range used in Slider
    });
  }

  void getData() {
    for (int i = 8; i <= 20; i++) {
      String time = i.toString().padLeft(2, '0') + ':00';
      int value =
          20 + random.nextInt(20); // Generates a number between 20 and 39
      data.add({
        'x': time,
        'y': value,
      });
    }
  }

  List<FlSpot> generateSpots() {
    return data.map((el) {
      int x =
      int.parse(el['x'].toString().split(':')[0]); // Extract hour as int
      double y = el['y'].toDouble(); // Ensure y is double
      return FlSpot(x.toDouble(), y);
    }).toList();
  }

  List<FlSpot> generateMaxSpots() {
    return data.map((el) {
      int x =
      int.parse(el['x'].toString().split(':')[0]); // Extract hour as int
      double y = _maxMoisture; // Ensure y is double
      return FlSpot(x.toDouble(), y);
    }).toList();
  }

  List<FlSpot> generateMinSpots() {
    return data.map((el) {
      int x =
      int.parse(el['x'].toString().split(':')[0]); // Extract hour as int
      double y = _minMoisture; // Ensure y is double
      return FlSpot(x.toDouble(), y);
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    getTemperatureFromDevice();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: theme.colorScheme.onPrimary,
        backgroundColor: theme.primaryColor,
        title: Text(
          "Moisture Chart",
          style: TextStyle(
              color: theme.colorScheme.onPrimary,
              fontSize: 24
          ),
        ),
      ),
      backgroundColor: theme.primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Column(
            children: [
              Container(
                height: 500,
                child: LineChart(
                  LineChartData(
                    minY: 0,
                    maxY: 100,
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toInt().toString(),
                              style:
                              TextStyle(color: theme.colorScheme.onPrimary),
                            );
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              '${value.toInt()}',
                              style:
                              TextStyle(color: theme.colorScheme.onPrimary),
                            );
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(color: theme.dividerColor),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: generateSpots(),
                        isCurved: true,
                        color: theme.colorScheme.secondary,
                        barWidth: 2,
                        belowBarData: BarAreaData(show: false),
                        dotData: FlDotData(show: true),
                      ),
                      LineChartBarData(
                        spots: generateMinSpots(),
                        isCurved: false,
                        color: Color.fromARGB(255, 81, 91, 193), // Darker color variant
                        barWidth: 2,
                        belowBarData: BarAreaData(show: false),
                        dotData: FlDotData(show: true),
                      ),
                      LineChartBarData(
                        spots: generateMaxSpots(),
                        isCurved: false,
                        color: theme.colorScheme.error, // Use the error color for red
                        barWidth: 2,
                        belowBarData: BarAreaData(show: false),
                        dotData: FlDotData(show: true),
                      ),
                    ],
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: theme.dividerColor,
                          strokeWidth: 1,
                          dashArray: [4],
                        );
                      },
                    ),
                  ),
                ),
              ),
              Legend(title: "Moisture", color: theme.colorScheme.secondary),
            ],
          ),
        ),
      ),
    );
  }
}