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
                'IoT Portal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 8,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/iot.webp",
                    scale: 2.5,
                  ),
                  SizedBox(height: 8,),
                  Text(
                    "Quy Do",
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8,),
                  Text(
                    "Administrator",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white54,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 20,),
          ListTile(
            textColor: tertiaryColor,
            iconColor: tertiaryColor,
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
            textColor: tertiaryColor,
            iconColor: tertiaryColor,
            leading: Icon(Icons.thermostat),
            title: Text('Temperatures'),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>(TemperatureTable())));
            },
          ),
          ListTile(
            textColor: tertiaryColor,
            iconColor: tertiaryColor,
            leading: Icon(Icons.water_drop_outlined),
            title: Text('Humidity'),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>(HumidityTable())));
            },
          ),
          ListTile(
            textColor: tertiaryColor,
            iconColor: tertiaryColor,
            leading: Icon(Icons.opacity),
            title: Text('Moisture'),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>(MoistureTable())));
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              "System",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          ListTile(
            textColor: tertiaryColor,
            iconColor: tertiaryColor,
            leading: Icon(Icons.settings),
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
