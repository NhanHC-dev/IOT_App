import 'package:flutter/material.dart';
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
  late double _maxTemp = 37 / 100;
  late double _minTemp = 3 / 100;

  // Variables for Humidity
  late double _maxHumidity = 80 / 100;
  late double _minHumidity = 20 / 100;

  // Variables for Moisture
  late double _maxMoisture = 60 / 100;
  late double _minMoisture = 10 / 100;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  // Load saved settings
  Future<void> _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _maxTemp = prefs.getDouble('maxTemp') ?? 37 / 100;
      _minTemp = prefs.getDouble('minTemp') ?? 3 / 100;
      _maxHumidity = prefs.getDouble('maxHumidity') ?? 80 / 100;
      _minHumidity = prefs.getDouble('minHumidity') ?? 20 / 100;
      _maxMoisture = prefs.getDouble('maxMoisture') ?? 60 / 100;
      _minMoisture = prefs.getDouble('minMoisture') ?? 10 / 100;
    });
  }

  // Save settings
  Future<void> _saveSettings(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('maxTemp', _maxTemp);
    await prefs.setDouble('minTemp', _minTemp);
    await prefs.setDouble('maxHumidity', _maxHumidity);
    await prefs.setDouble('minHumidity', _minHumidity);
    await prefs.setDouble('maxMoisture', _maxMoisture);
    await prefs.setDouble('minMoisture', _minMoisture);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Dashboard()));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.primaryColor,
      drawer: MainDrawer(),
      appBar: MainAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: ListView(
          children: [
            Text("Settings",
              style: TextStyle(
                  color: theme.colorScheme.onPrimary,
                  fontSize: 36
              ),
            ),
            Text(
              "Save your settings",
              style: TextStyle(
                  color: theme.colorScheme.secondary,
                  fontSize: 14
              ),
            ),
            const SizedBox(height: 16),
            Text("Temperatures", style: theme.textTheme.headlineMedium?.copyWith(color: theme.colorScheme.onPrimary)),
            Text("Maximum", style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onPrimary)),
            Slider(
              activeColor: theme.colorScheme.secondary,
              inactiveColor: theme.colorScheme.secondary.withOpacity(0.2),
              value: _maxTemp,
              onChanged: (newValue) {
                setState(() {
                  _maxTemp = newValue;
                });
              },
              min: 0.0,
              max: 0.37,
              divisions: 100,
              label: (_maxTemp * 100).toStringAsFixed(0) + '°C',
            ),
            Text("Minimum", style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onPrimary)),
            Slider(
              activeColor: theme.colorScheme.secondary,
              inactiveColor: theme.colorScheme.secondary.withOpacity(0.2),
              value: _minTemp,
              onChanged: (newValue) {
                setState(() {
                  _minTemp = newValue;
                });
              },
              min: 0.0,
              max: 0.37,
              divisions: 100,
              label: (_minTemp * 100).toStringAsFixed(0) + '°C',
            ),
            const SizedBox(height: 24),
            Text("Humidity", style: theme.textTheme.headlineMedium?.copyWith(color: theme.colorScheme.onPrimary)),
            Text("Maximum", style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onPrimary)),
            Slider(
              activeColor: theme.colorScheme.secondary,
              inactiveColor: theme.colorScheme.secondary.withOpacity(0.2),
              value: _maxHumidity,
              onChanged: (newValue) {
                setState(() {
                  _maxHumidity = newValue;
                });
              },
              min: 0.0,
              max: 1.0,
              divisions: 100,
              label: (_maxHumidity * 100).toStringAsFixed(0) + '%',
            ),
            Text("Minimum", style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onPrimary)),
            Slider(
              activeColor: theme.colorScheme.secondary,
              inactiveColor: theme.colorScheme.secondary.withOpacity(0.2),
              value: _minHumidity,
              onChanged: (newValue) {
                setState(() {
                  _minHumidity = newValue;
                });
              },
              min: 0.0,
              max: 1.0,
              divisions: 100,
              label: (_minHumidity * 100).toStringAsFixed(0) + '%',
            ),
            const SizedBox(height: 24),
            Text("Moisture", style: theme.textTheme.headlineMedium?.copyWith(color: theme.colorScheme.onPrimary)),
            Text("Maximum", style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onPrimary)),
            Slider(
              activeColor: theme.colorScheme.secondary,
              inactiveColor: theme.colorScheme.secondary.withOpacity(0.2),
              value: _maxMoisture,
              onChanged: (newValue) {
                setState(() {
                  _maxMoisture = newValue;
                });
              },
              min: 0.0,
              max: 1.0,
              divisions: 100,
              label: (_maxMoisture * 100).toStringAsFixed(0) + '%',
            ),
            Text("Minimum", style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onPrimary)),
            Slider(
              activeColor: theme.colorScheme.secondary,
              inactiveColor: theme.colorScheme.secondary.withOpacity(0.2),
              value: _minMoisture,
              onChanged: (newValue) {
                setState(() {
                  _minMoisture = newValue;
                });
              },
              min: 0.0,
              max: 1.0,
              divisions: 100,
              label: (_minMoisture * 100).toStringAsFixed(0) + '%',
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.secondary,
                  foregroundColor: theme.colorScheme.onPrimary,
                ),
                onPressed: () {
                  _saveSettings(context);
                },
                child: Text("Save", style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSecondary)),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

