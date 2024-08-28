import 'package:flutter/material.dart';
import 'package:iot_app/dashboard.dart';
import 'package:iot_app/datalogtable/humidity_table.dart';
import 'package:iot_app/datalogtable/moisture_table.dart';
import 'package:iot_app/settings.dart';

import 'datalogtable/temparature_table.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {

  Color primaryColor = Color.fromARGB(255, 21, 28, 47);
  Color secondaryColor = Color.fromARGB(255, 32, 50, 77);
  Color tertiaryColor = Color.fromARGB(255, 37, 213, 179);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: primaryColor,
      width: 200,
      child: ListView(
        children: [
          Column(
            children: [
              Text(
                'IoT ADMIN',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/iot.png",
                    scale: 0.5,
                  ),
                  Text(
                    "Quy Do",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Administrator",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              )
            ],
          ),
          ListTile(
            textColor: Colors.white,
            iconColor: Colors.white,
            leading: Icon(Icons.home),
            title: Text('Dashboard'),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>(Dashboard())));
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              "Data",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          ListTile(
            textColor: Colors.white,
            iconColor: Colors.white,
            leading: Icon(Icons.thermostat),
            title: Text('Temperatures'),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>(TemperatureTable())));
            },
          ),
          ListTile(
            textColor: Colors.white,
            iconColor: Colors.white,
            leading: Icon(Icons.settings),
            title: Text('Humidity'),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>(HumidityTable())));
            },
          ),
          ListTile(
            textColor: Colors.white,
            iconColor: Colors.white,
            leading: Icon(Icons.water_drop),
            title: Text('Moisture'),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>(MoistureTable())));
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              "Settings",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          ListTile(
            textColor: Colors.white,
            iconColor: Colors.white,
            leading: Icon(Icons.contacts),
            title: Text('Settings'),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>(Settings())));
            },
          ),
        ],
      ),
    );
  }
}
