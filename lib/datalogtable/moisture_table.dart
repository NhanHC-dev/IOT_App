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
    return Scaffold(
        backgroundColor: primaryColor,
        drawer: MainDrawer(),
        appBar: AppBar(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          title: Text(
            "Moisture",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Card(
                  color: secondaryColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 7, // 3 parts for the first column
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data[index]["sensorName"],
                                style: TextStyle(
                                  color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                data[index]["location"],
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                data[index]["dateTime"],
                                style: TextStyle(
                                  color: tertiaryColor,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 2, // 2 parts for the second column
                          child: Transform.translate(
                            offset: Offset(-10, 0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.opacity,
                                  color: tertiaryColor,
                                  size: 40,
                                ),
                                Text(
                                  data[index]["moisture"]+"%",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: tertiaryColor
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
        )
    );
  }
}
