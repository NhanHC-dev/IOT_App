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
    IconData icon = Icons.home,
    required double width,
    required double height,
    required String average,
    required String label,
    required double percentage,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: secondaryColor,
      ),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding:  EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      width: width,
      height: height,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: tertiaryColor,
                  size: 28,
                ),
                SizedBox(height: 8.0),
                Text(
                  average.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  label,
                  style: TextStyle(
                      color: tertiaryColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  value: percentage * 0.01,
                  strokeWidth: 5.0,
                  color: tertiaryColor,
                  backgroundColor: tertiaryColor.withOpacity(0.2),
                ),
                SizedBox(height: 8.0),
                Text(
                  '${percentage}%',
                  style: TextStyle(
                    color: tertiaryColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ]
      ),
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
        title: Text("IoT System"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute (
                  builder: (BuildContext context) => const TempChart(),
                ));
              },
              child: GeneralCard(
                height: 120,
                width: screenWidth,
                label: "Temperature",
                average: avgTemp.toString() + "°C",
                percentage: 91,
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute (
                  builder: (BuildContext context) => const HumidityChart(),
                ));
              },
              child: GeneralCard(
                height: 120,
                width: screenWidth,
                label: "Humidity",
                average: avgHum.toString() + "%",
                percentage: 67,
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute (
                  builder: (BuildContext context) => const MoistureChart(),
                ));
              },
              child: GeneralCard(
                height: 120,
                width: screenWidth,
                label: "Moisture",
                average: avgMois.toString() + "%",
                percentage: 34,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
