import 'package:flutter/material.dart';
import 'package:iot_app/drawer.dart';

class HumidityTable extends StatefulWidget {
  const HumidityTable({super.key});

  @override
  State<HumidityTable> createState() => _HumidityTableState();
}

class _HumidityTableState extends State<HumidityTable> {
  Color primaryColor = Color.fromARGB(255, 21, 28, 47);
  Color secondaryColor = Color.fromARGB(255, 32, 50, 77);
  Color tertiaryColor = Color.fromARGB(255, 37, 213, 179);

  late List<Map<String, dynamic>> data = [
    {
      "id": 1,
      "dateTime": '8/27/2024, 11:30:00 PM',
      "sensorName": 'Temperature Sensor #01',
      "location": 'Weed Garden - 80 Le Loi, Da Nang, Viet Nam',
      "humidity": '40',
    },
    {
      "id": 2,
      "dateTime": '8/27/2024, 11:30:00 PM',
      "sensorName": 'Temperature Sensor #01',
      "location": 'Weed Garden - 80 Le Loi, Da Nang, Viet Nam',
      "humidity": '40',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      drawer: MainDrawer(),
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: Text(
          "Humidity",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: DataTable(
            headingRowColor:
                WidgetStateColor.resolveWith((states) => secondaryColor),
            dataRowColor:
                WidgetStateColor.resolveWith((states) => primaryColor),
            columnSpacing: 20,
            columns: [
              DataColumn(
                label: Text(
                  'Date Time',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              DataColumn(
                label: Text(
                  'Sensor Name',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              DataColumn(
                label: Text(
                  'Location',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              DataColumn(
                label: Text(
                  'Humidity',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
            rows: [
              ...data
                  .map(
                    (item) => DataRow(
                      cells: [
                        DataCell(Text(item['dateTime']!,
                            style: TextStyle(color: Colors.white))),
                        DataCell(Text(item['sensorName']!,
                            style: TextStyle(color: Colors.white))),
                        DataCell(Text(item['location']!,
                            style: TextStyle(color: Colors.white))),
                        DataCell(Text(item['humidity']!+"%",
                            style: TextStyle(color: Colors.white))),
                      ],
                    ),
                  )
                  .toList()
            ],
          ),
        ),
      ),
    );
  }
}
