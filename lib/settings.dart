import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iot_app/appbar.dart';
import 'package:iot_app/dashboard.dart';
import 'package:iot_app/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  // Variables for Temperature
  late double? _maxTemp;
  late double? _minTemp;

  // Variables for Humidity
  late double? _maxHumidity;
  late double? _minHumidity;

  // Variables for Moisture
  late double? _maxMoisture;
  late double? _minMoisture;

  late String sensorName = "";

  List<Map<String, dynamic>> settings = [
    {
      "id": 9,
      "max_humidity": 90.0,
      "max_moisture": null,
      "max_temperature": 27.0,
      "min_humidity": 10.0,
      "min_moisture": null,
      "min_temperature": 10.0,
      "sensor_id": 1
    },
    {
      "id": 10,
      "max_humidity": null,
      "max_moisture": 90.0,
      "max_temperature": null,
      "min_humidity": null,
      "min_moisture": 10.0,
      "min_temperature": null,
      "sensor_id": 2
    }
  ];

  // Define sensors as a list of maps
  List<Map<String, dynamic>> sensors = [
    {
      "id": 1,
      "location": "Weed Garden",
      "location_id": 1,
      "name": "DHT11",
      "type": "temperature",
      "type_id": 1
    },
    {
      "id": 2,
      "location": "Weed Garden",
      "location_id": 1,
      "name": "SMSV1",
      "type": "moisture",
      "type_id": 2
    }
  ];

  late String? _selectedOption = null;

  @override
  void initState() {
    super.initState();
    _loadSettings();
    _updateSliderValues();
  }

  // Load saved settings
  Future<void> _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _maxTemp = prefs.getDouble('maxTemp');
      _minTemp = prefs.getDouble('minTemp');
      _maxHumidity = prefs.getDouble('maxHumidity');
      _minHumidity = prefs.getDouble('minHumidity');
      _maxMoisture = prefs.getDouble('maxMoisture');
      _minMoisture = prefs.getDouble('minMoisture');
    });
  }

  // Save settings
  Future<void> _saveSettings(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    (_maxTemp != null)
        ?await prefs.setDouble('maxTemp', _maxTemp!)
        : null;
    (_minTemp != null)
        ?await prefs.setDouble('minTemp', _minTemp!)
        : null;
    (_maxHumidity != null)
        ?await prefs.setDouble('maxHumidity', _maxHumidity!)
        : null;
    (_minHumidity != null)
        ?await prefs.setDouble('minHumidity', _minHumidity!)
        : null;
    (_maxMoisture != null)
        ?await prefs.setDouble('maxMoisture', _maxMoisture!)
        : null;
    (_minMoisture != null)
        ?await prefs.setDouble('minMoisture', _minMoisture!)
        : null;
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Dashboard()));
  }

  // Update slider values based on selected sensor
  void _updateSliderValues() {
    final selectedSensor = sensors.firstWhere(
        (sensor) => sensor['name'] == _selectedOption,
        orElse: () => {});
    if (selectedSensor.isNotEmpty) {
      final sensorId = selectedSensor['id'];
      final settingsForSensor = settings.firstWhere(
        (setting) => setting['sensor_id'] == sensorId,
        orElse: () => {},
      );
      setState(() {
        _maxTemp = (settingsForSensor['max_temperature'] != null)
            ? settingsForSensor['max_temperature'] / 100
            : null;
        _minTemp = settingsForSensor['min_temperature'] != null
            ? settingsForSensor['min_temperature'] / 100
            : null;
        _maxHumidity = settingsForSensor['max_humidity'] != null
            ? settingsForSensor['max_humidity'] / 100
            : null;
        _minHumidity = settingsForSensor['min_humidity'] != null
            ? settingsForSensor['min_humidity'] / 100
            : null;
        _maxMoisture = settingsForSensor['max_moisture'] != null
            ? settingsForSensor['max_moisture'] / 100
            : null;
        _minMoisture = settingsForSensor['min_moisture'] != null
            ? settingsForSensor['min_moisture'] / 100
            : null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.primaryColor,
      drawer: MainDrawer(
        currentScreen: 'Settings',
      ),
      appBar: MainAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: ListView(children: [
          Text(
            "Settings",
            style: TextStyle(color: theme.colorScheme.onPrimary, fontSize: 36),
          ),
          Row(
            children: [
              Text(
                "Save your settings for sensor ",
                style:
                    TextStyle(color: theme.colorScheme.secondary, fontSize: 14),
              ),
              DropdownMenu<String>(
                trailingIcon: Icon(
                  Icons.add,
                  size: 0,
                ),
                selectedTrailingIcon: Icon(
                  Icons.add,
                  size: 0,
                ),
                onSelected: (String? newValue) {
                  setState(() {
                    _selectedOption = newValue!;
                    _updateSliderValues();
                  });
                },
                inputDecorationTheme: InputDecorationTheme(
                  constraints: BoxConstraints(
                    maxHeight: 46,
                  ),
                  contentPadding: EdgeInsets.all(0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                hintText: "None",
                dropdownMenuEntries:
                    sensors.map<DropdownMenuEntry<String>>((sensor) {
                  return DropdownMenuEntry<String>(
                    value: sensor['name'], // Use sensor name
                    label: sensor['name'], // Display sensor name
                  );
                }).toList(),
                menuStyle: MenuStyle(
                  backgroundColor: WidgetStateProperty.all(
                      theme.cardColor), // secondary color
                  shadowColor: WidgetStateProperty.all(
                      theme.cardColor.withOpacity(0.2)), // tertiary color
                ),
                textStyle: TextStyle(
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            ],
          ),
          if (_selectedOption != null) ...[
            const SizedBox(height: 16),
            if (_maxTemp != null) ...[
              Text("Temperatures",
                  style: theme.textTheme.headlineMedium
                      ?.copyWith(color: theme.colorScheme.onPrimary)),
              Text("Maximum",
                  style: theme.textTheme.bodyLarge
                      ?.copyWith(color: theme.colorScheme.onPrimary)),
              Slider(
                activeColor: theme.colorScheme.secondary,
                inactiveColor: theme.colorScheme.secondary.withOpacity(0.2),
                value: _maxTemp!,
                onChanged: (newValue) {
                  setState(() {
                    _maxTemp = newValue;
                  });
                },
                min: 0.0,
                max: 0.37,
                divisions: 100,
                label: (_maxTemp! * 100).toStringAsFixed(0) + '°C',
              ),
              Text("Minimum",
                  style: theme.textTheme.bodyLarge
                      ?.copyWith(color: theme.colorScheme.onPrimary)),
              Slider(
                activeColor: theme.colorScheme.secondary,
                inactiveColor: theme.colorScheme.secondary.withOpacity(0.2),
                value: _minTemp!,
                onChanged: (newValue) {
                  setState(() {
                    _minTemp = newValue;
                  });
                },
                min: 0.0,
                max: 0.37,
                divisions: 100,
                label: (_minTemp! * 100).toStringAsFixed(0) + '°C',
              ),
              const SizedBox(height: 24),
            ],
            if (_maxHumidity != null) ...[
              Text("Humidity",
                  style: theme.textTheme.headlineMedium
                      ?.copyWith(color: theme.colorScheme.onPrimary)),
              Text("Maximum",
                  style: theme.textTheme.bodyLarge
                      ?.copyWith(color: theme.colorScheme.onPrimary)),
              Slider(
                activeColor: theme.colorScheme.secondary,
                inactiveColor: theme.colorScheme.secondary.withOpacity(0.2),
                value: _maxHumidity!,
                onChanged: (newValue) {
                  setState(() {
                    _maxHumidity = newValue;
                  });
                },
                min: 0.0,
                max: 1.0,
                divisions: 100,
                label: (_maxHumidity! * 100).toStringAsFixed(0) + '%',
              ),
              Text("Minimum",
                  style: theme.textTheme.bodyLarge
                      ?.copyWith(color: theme.colorScheme.onPrimary)),
              Slider(
                activeColor: theme.colorScheme.secondary,
                inactiveColor: theme.colorScheme.secondary.withOpacity(0.2),
                value: _minHumidity!,
                onChanged: (newValue) {
                  setState(() {
                    _minHumidity = newValue;
                  });
                },
                min: 0.0,
                max: 1.0,
                divisions: 100,
                label: (_minHumidity! * 100).toStringAsFixed(0) + '%',
              ),
              const SizedBox(height: 24),
            ],
            if (_maxMoisture != null) ...[
              Text("Moisture",
                  style: theme.textTheme.headlineMedium
                      ?.copyWith(color: theme.colorScheme.onPrimary)),
              Text("Maximum",
                  style: theme.textTheme.bodyLarge
                      ?.copyWith(color: theme.colorScheme.onPrimary)),
              Slider(
                activeColor: theme.colorScheme.secondary,
                inactiveColor: theme.colorScheme.secondary.withOpacity(0.2),
                value: _maxMoisture!,
                onChanged: (newValue) {
                  setState(() {
                    _maxMoisture = newValue;
                  });
                },
                min: 0.0,
                max: 1.0,
                divisions: 100,
                label: (_maxMoisture! * 100).toStringAsFixed(0) + '%',
              ),
              Text("Minimum",
                  style: theme.textTheme.bodyLarge
                      ?.copyWith(color: theme.colorScheme.onPrimary)),
              Slider(
                activeColor: theme.colorScheme.secondary,
                inactiveColor: theme.colorScheme.secondary.withOpacity(0.2),
                value: _minMoisture!,
                onChanged: (newValue) {
                  setState(() {
                    _minMoisture = newValue;
                  });
                },
                min: 0.0,
                max: 1.0,
                divisions: 100,
                label: (_minMoisture! * 100).toStringAsFixed(0) + '%',
              ),
              const SizedBox(height: 24),
            ],
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.secondary,
                  foregroundColor: theme.colorScheme.onPrimary,
                ),
                onPressed: () {
                  _saveSettings(context);
                },
                child: Text("Save",
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: theme.colorScheme.onSecondary)),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ]),
      ),
    );
  }
}
