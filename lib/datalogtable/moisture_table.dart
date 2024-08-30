import 'package:flutter/material.dart';
import 'package:iot_app/appbar.dart';
import 'package:iot_app/drawer.dart';

class MoistureTable extends StatefulWidget {
  const MoistureTable({super.key});

  @override
  State<MoistureTable> createState() => _MoistureTableState();
}

class _MoistureTableState extends State<MoistureTable> {
  late List<Map<String, dynamic>> data = [
    {
      "id": 1,
      "dateTime": '8/27/2024, 11:30:00 PM',
      "sensorName": 'Temperature Sensor #01',
      "location": 'Weed Garden - 80 Le Loi, Da Nang, Viet Nam',
      "moisture": '40',
    },
    {
      "id": 2,
      "dateTime": '8/27/2024, 11:30:00 PM',
      "sensorName": 'Temperature Sensor #01',
      "location": 'Weed Garden - 80 Le Loi, Da Nang, Viet Nam',
      "moisture": '40',
    },
    {
      "id": 3,
      "dateTime": '8/27/2024, 11:30:00 PM',
      "sensorName": 'Temperature Sensor #01',
      "location": 'Weed Garden - 80 Le Loi, Da Nang, Viet Nam',
      "moisture": '56',
    },
    {
      "id": 2,
      "dateTime": '8/27/2024, 11:30:00 PM',
      "sensorName": 'Temperature Sensor #01',
      "location": 'Weed Garden - 80 Le Loi, Da Nang, Viet Nam',
      "moisture": '76',
    },
    {
      "id": 2,
      "dateTime": '8/27/2024, 11:30:00 PM',
      "sensorName": 'Temperature Sensor #01',
      "location": 'Weed Garden - 80 Le Loi, Da Nang, Viet Nam',
      "moisture": '93',
    },
    {
      "id": 2,
      "dateTime": '8/27/2024, 11:30:00 PM',
      "sensorName": 'Temperature Sensor #01',
      "location": 'Weed Garden - 80 Le Loi, Da Nang, Viet Nam',
      "moisture": '16',
    }
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.primaryColor,
      drawer: MainDrawer(currentScreen: 'MoistureTable',),
      appBar: MainAppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Moisture",
                    style: TextStyle(
                        color: theme.colorScheme.onPrimary,
                        fontSize: 36
                    ),
                  ),
                  Text(
                    "List of moisture information",
                    style: TextStyle(
                        color: theme.colorScheme.secondary,
                        fontSize: 14
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16,),
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: theme.cardColor,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data[index]["sensorName"],
                                  style: TextStyle(
                                    color: theme.colorScheme.onPrimary,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  data[index]["location"],
                                  style: TextStyle(
                                    color: theme.colorScheme.onPrimary.withOpacity(0.6),
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 12),
                                Text(
                                  data[index]["dateTime"],
                                  style: TextStyle(
                                    color: theme.colorScheme.secondary,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Transform.translate(
                              offset: Offset(-10, 0),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.opacity,
                                    color: theme.colorScheme.secondary,
                                    size: 40,
                                  ),
                                  Text(
                                    data[index]["moisture"] + "%",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: theme.colorScheme.secondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
