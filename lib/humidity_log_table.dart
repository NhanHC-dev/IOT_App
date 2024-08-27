import 'package:flutter/material.dart';

class HumidityLogTable extends StatelessWidget {
  final List<dynamic> data;

  HumidityLogTable({required this.data});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(label: Text('Date')),
        DataColumn(label: Text('Humidity')),
      ],
      rows: data.map((item) {
        return DataRow(
          cells: [
            DataCell(Text(item['date'])),
            DataCell(Text(item['humidity'].toString())),
          ],
        );
      }).toList(),
    );
  }
}
