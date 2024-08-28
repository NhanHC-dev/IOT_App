import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:iot_app/charts/legend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

class TempChart extends StatefulWidget {
  const TempChart({super.key});

  @override
  State<TempChart> createState() => _TempChartState();
}

class _TempChartState extends State<TempChart> {

  late double _minTemp = 0;
  late double _maxTemp = 0;

  late List<Map<String, dynamic>> data = [];
  final Random random = Random();

  Color primaryColor = Color.fromARGB(255, 21, 28, 47);
  Color secondaryColor = Color.fromARGB(255, 32, 50, 77);
  Color tertiaryColor = Color.fromARGB(255, 37, 213, 179);

  Future<void> getTemperatureFromDevice() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve stored values or set default values if not available
    double minTemp = prefs.getDouble('minTemp') ?? 3.0; // Default min temperature 3°C
    double maxTemp = prefs.getDouble('maxTemp') ?? 37.0; // Default max temperature 37°C

    setState(() {
      _minTemp = minTemp*100; // Convert to range used in Slider
      _maxTemp = maxTemp*100; // Convert to range used in Slider
    });
  }
  void getData(){
    for (int i = 8; i <= 20; i++) {
      String time = i.toString().padLeft(2, '0') + ':00';
      int value = 20 + random.nextInt(20); // Generates a number between 20 and 39
      data.add({
        'x': time,
        'y': value,
      });
    }
  }
  List<FlSpot> generateSpots() {
    return data.map((el) {
      int x = int.parse(el['x'].toString().split(':')[0]); // Extract hour as int
      double y = el['y'].toDouble(); // Ensure y is double
      return FlSpot(x.toDouble(), y);
    }).toList();
  }

  List<FlSpot> generateMaxSpots() {
    return data.map((el) {
      int x = int.parse(el['x'].toString().split(':')[0]); // Extract hour as int
      double y = _maxTemp; // Ensure y is double
      return FlSpot(x.toDouble(), y);
    }).toList();
  }

  List<FlSpot> generateMinSpots() {
    return data.map((el) {
      int x = int.parse(el['x'].toString().split(':')[0]); // Extract hour as int
      double y = _minTemp; // Ensure y is double
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
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: primaryColor,
        title: Text("Temperature Chart"),
      ),
      backgroundColor: primaryColor,
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
                    maxY: 40,
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toInt().toString(),
                              style: const TextStyle(color: Colors.white),
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
                              style: const TextStyle(color: Colors.white),
                            );
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(color: const Color(0xFF707070)),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: generateMaxSpots(),
                        isCurved: true,
                        color: Colors.redAccent,
                        barWidth: 2,
                        belowBarData: BarAreaData(show: false),
                        dotData: FlDotData(show: true),
                      ),
                      LineChartBarData(
                        spots: generateMinSpots(),
                        isCurved: false,
                        color: Colors.blueAccent,
                        barWidth: 2,
                        belowBarData: BarAreaData(show: false),
                        dotData: FlDotData(show: true),
                      ),
                      LineChartBarData(
                        spots: generateSpots(),
                        isCurved: false,
                        color: Colors.tealAccent,
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
                          color: const Color(0xFF707070),
                          strokeWidth: 1,
                          dashArray: [4],
                        );
                      },
                    ),
                  ),
                ),
              ),
              Legend()
            ],
          ),
        ),
      ),
    );
  }
}
