import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:iot_app/charts/humidity_chart.dart';
import 'package:iot_app/charts/moisture_chart.dart';
import 'package:iot_app/charts/temp_chart.dart';
import 'package:iot_app/dashboard.dart';
import 'package:iot_app/datalogtable/temparature_table.dart';
import 'package:iot_app/drawer.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<double> temperatureData = [];
  List<dynamic> humidityData = [];
  List<dynamic> filteredTemperatureData = [];
  List<dynamic> filteredHumidityData = [];
  double maxTempFixed = 100;
  double minTempFixed = 0;
  double maxHumidity = 100;
  double minHumidity = 0;

  double avgTemp = 32;
  double avgHum = 67;
  double avgMois = 30;

  Color primaryColor = Color.fromARGB(255, 21, 28, 47);
  Color secondaryColor = Color.fromARGB(255, 32, 50, 77);
  Color tertiaryColor = Color.fromARGB(255, 37, 213, 179);

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);

    setState(() {
      temperatureData = data['temperature'];
      humidityData = data['humidity'];
    });
  }

  void handleTemperatureFormSubmit(Map<String, dynamic> formData) {
    setState(() {
      maxTempFixed = formData['maxTempFixed'];
      minTempFixed = formData['minTempFixed'];
      filteredTemperatureData = filterData(
        temperatureData,
        maxTempFixed,
        minTempFixed,
        formData['startDate'],
        formData['endDate'],
        'temperature',
      );
    });
  }

  void handleHumidityFormSubmit(Map<String, dynamic> formData) {
    setState(() {
      maxHumidity = formData['maxHumidity'];
      minHumidity = formData['minHumidity'];
      filteredHumidityData = filterData(
        humidityData,
        maxHumidity,
        minHumidity,
        formData['startDate'],
        formData['endDate'],
        'humidity',
      );
    });
  }

  List<dynamic> filterData(
    List<dynamic> data,
    double max,
    double min,
    String? startDate,
    String? endDate,
    String type,
  ) {
    // Filtering logic here
    return data.where((item) {
      final value = item['value'];
      return value >= min && value <= max;
    }).toList();
  }

  Widget GeneralCard({
    IconData icon = Icons.question_mark,
    required double width,
    required double height,
    required String average,
    required String label,
    required double percentage,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: secondaryColor,
      ),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      width: width,
      height: height,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                  color: color,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Icon(
              icon,
              color: color,
              size:42,
            ),
            SizedBox(height: 16.0),
            Text(
              average.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
              ),
            ),

          ],
        ),
        Stack(
          alignment: Alignment.center, // Center the text within the progress indicator
          children: [
            SizedBox(
              height: 120,
              width: 120,
              child: CircularProgressIndicator(
                value: percentage * 0.01,
                strokeWidth: 8.0,
                color: color,
                backgroundColor: Color.fromARGB(255, 81, 91, 193).withOpacity(0.6)
              ),
            ),
            Text(
              '${percentage}%', // Display the percentage value
              style: TextStyle(
                color: color,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: primaryColor,
      drawer: MainDrawer(),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: primaryColor,
        actions: [
          Icon(Icons.dark_mode_outlined),
          SizedBox(width: 24,),
          Icon(Icons.notifications_none_outlined),
          SizedBox(width: 18,)
        ],
      ),
      body: SafeArea(
        child: Transform.translate(
          offset: Offset(0, -10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20,right: 20, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Text("IoT System",
                      style: TextStyle(color: Colors.white, fontSize: 36),
                    ),
                    Text(
                      "Welcome to your Weed Garden",
                      style: TextStyle(color: tertiaryColor, fontSize: 14),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const TempChart(),
                  ));
                },
                child: GeneralCard(
                  icon: Icons.thermostat,
                  height: 180,
                  width: screenWidth,
                  label: "Temperature",
                  average: avgTemp.toString() + "°C",
                  percentage: 91,
                  color: tertiaryColor
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const HumidityChart(),
                  ));
                },
                child: GeneralCard(
                  icon: Icons.water_drop_outlined,
                  height: 180,
                  width: screenWidth,
                  label: "Humidity",
                  average: avgHum.toString() + "%",
                  percentage: 67,
                  color: tertiaryColor
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const MoistureChart(),
                  ));
                },
                child: GeneralCard(
                  icon: Icons.opacity,
                  height: 180,
                  width: screenWidth,
                  label: "Moisture",
                  average: avgMois.toString() + "%",
                  percentage: 34,
                  color: tertiaryColor
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
