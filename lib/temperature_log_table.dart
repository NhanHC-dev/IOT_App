import 'package:flutter/material.dart';

class TemperatureLogTable extends StatelessWidget {
  final List<dynamic> data;

  TemperatureLogTable({required this.data});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(label: Text('Date')),
        DataColumn(label: Text('Temperature')),
      ],
      rows: data.map((item) {
        return DataRow(
          cells: [
            DataCell(Text(item['date'])),
            DataCell(Text(item['temperature'].toString())),
          ],
        );
      }).toList(),
    );
  }
}
