import 'package:flutter/material.dart';
import 'package:iot_app/drawer.dart';

class MoistureTable extends StatefulWidget {
  const MoistureTable({super.key});

  @override
  State<MoistureTable> createState() => _MoistureTableState();
}

class _MoistureTableState extends State<MoistureTable> {
  Color primaryColor = Color.fromARGB(255, 21, 28, 47);
  Color secondaryColor = Color.fromARGB(255, 32, 50, 77);
  Color tertiaryColor = Color.fromARGB(255, 37, 213, 179);

  late List<Map<String, String>> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      drawer: MainDrawer(),
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: Text(
          "Temperatures",
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
                  'Temperature',
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
                        DataCell(Text(item['temperature']!,
                            style: TextStyle(color: Colors.white))),
                      ],
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
