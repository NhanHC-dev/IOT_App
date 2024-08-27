import 'package:flutter/material.dart';
import 'temperature_form.dart';
import 'temperature_chart.dart';
import 'temperature_log_table.dart';

class TemperatureSection extends StatelessWidget {
  final Function(Map<String, dynamic>) onFormSubmit;
  final List<dynamic> filteredData;
  final double maxTempFixed;
  final double minTempFixed;

  TemperatureSection({
    required this.onFormSubmit,
    required this.filteredData,
    required this.maxTempFixed,
    required this.minTempFixed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Temperature Data',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        TemperatureForm(onFormSubmit: onFormSubmit),
        TemperatureChart(
          data: filteredData,
          maxTempFixed: maxTempFixed,
          minTempFixed: minTempFixed,
        ),
        TemperatureLogTable(data: filteredData),
      ],
    );
  }
}
