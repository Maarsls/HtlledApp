// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:htl_led/BLE/FindDevicesScreenBLE.dart';
import 'package:htl_led/FindDevicesScreen.dart';

class DeviceChange extends StatefulWidget {
  const DeviceChange({Key? key}) : super(key: key);

  @override
  _DeviceChangeState createState() => _DeviceChangeState();
}

class _DeviceChangeState extends State<DeviceChange> {
  // ignore: prefer_final_fields
  List<Widget> _children = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    _children.add(FindDevicesScreenBLE());
    _children.add(const FindDevicesScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gefundene Geräte"),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _children,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.rotate_90_degrees_ccw),
            label: 'BLE',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_alarm),
            label: 'Seriell',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightBlue,
        onTap: onItemTapped,
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
