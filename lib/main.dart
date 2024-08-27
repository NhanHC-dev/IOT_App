import 'package:flutter/material.dart';
import 'temperature_section.dart';
import 'humidity_section.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(IotApp());
}

class IotApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IoT Monitoring System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> temperatureData = [];
  List<dynamic> humidityData = [];
  List<dynamic> filteredTemperatureData = [];
  List<dynamic> filteredHumidityData = [];
  double maxTempFixed = 100;
  double minTempFixed = 0;
  double maxHumidity = 100;
  double minHumidity = 0;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/anh4.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.7), BlendMode.darken),
                ),
              ),
              child: Center(
                child: Text(
                  'IoT Monitoring System',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            TemperatureSection(
              onFormSubmit: handleTemperatureFormSubmit,
              filteredData: filteredTemperatureData,
              maxTempFixed: maxTempFixed,
              minTempFixed: minTempFixed,
            ),
            SizedBox(height: 20),
            HumiditySection(
              onFormSubmit: handleHumidityFormSubmit,
              filteredHumidityData: filteredHumidityData,
              maxHumidity: maxHumidity,
              minHumidity: minHumidity,
            ),
          ],
        ),
      ),
    );
  }
}
