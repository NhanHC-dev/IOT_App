import 'package:flutter/material.dart';

class TemperatureForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onFormSubmit;

  TemperatureForm({required this.onFormSubmit});

  @override
  _TemperatureFormState createState() => _TemperatureFormState();
}

class _TemperatureFormState extends State<TemperatureForm> {
  double maxTempFixed = 100;
  double minTempFixed = 0;
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
            values: RangeValues(minTempFixed, maxTempFixed),
            onChanged: (values) {
              setState(() {
                minTempFixed = values.start;
                maxTempFixed = values.end;
              });
            },
          ),
          // Start and End Date input fields
          ElevatedButton(
            onPressed: () {
              widget.onFormSubmit({
                'maxTempFixed': maxTempFixed,
                'minTempFixed': minTempFixed,
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
