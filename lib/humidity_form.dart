import 'package:flutter/material.dart';

class HumidityForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onFormSubmit;

  HumidityForm({required this.onFormSubmit});

  @override
  _HumidityFormState createState() => _HumidityFormState();
}

class _HumidityFormState extends State<HumidityForm> {
  double maxHumidity = 100;
  double minHumidity = 0;
  String? startDate;
  String? endDate;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          RangeSlider(
            min: 0,
            max: 100,
            divisions: 100,
            values: RangeValues(minHumidity, maxHumidity),
            onChanged: (values) {
              setState(() {
                minHumidity = values.start;
                maxHumidity = values.end;
              });
            },
          ),
          // Start and End Date input fields
          ElevatedButton( 
            onPressed: () {
              widget.onFormSubmit({
                'maxHumidity': maxHumidity,
                'minHumidity': minHumidity,
                'startDate': startDate,
                'endDate': endDate,
              });
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
