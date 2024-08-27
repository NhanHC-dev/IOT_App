import 'package:flutter/material.dart';
import 'humidity_form.dart';
import 'humidity_chart.dart';
import 'humidity_log_table.dart';

class HumiditySection extends StatelessWidget {
  final Function(Map<String, dynamic>) onFormSubmit;
  final List<dynamic> filteredHumidityData;
  final double maxHumidity;
  final double minHumidity;

  HumiditySection({
    required this.onFormSubmit,
    required this.filteredHumidityData,
    required this.maxHumidity,
    required this.minHumidity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Humidity Data',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        HumidityForm(onFormSubmit: onFormSubmit),
        HumidityChart(
          data: filteredHumidityData,
          maxHumidity: maxHumidity,
          minHumidity: minHumidity,
        ),
        HumidityLogTable(data: filteredHumidityData),
      ],
    );
  }
}
