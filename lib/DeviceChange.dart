// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:htl_led/BLE/FindDevicesScreenBLE.dart';
import 'package:htl_led/FindDevicesScreen.dart';
import 'dart:io' show Platform;

import 'package:htl_led/Information.dart';

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
    if (!Platform.isIOS) _children.add(const FindDevicesScreen());
    _children.add(Information());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (_selectedIndex != 2)
            ? Text("Gefundene Geräte")
            : Text("Informationen"),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _children,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.bluetooth),
            label: 'BLE',
          ),
          if (!Platform.isIOS)
            BottomNavigationBarItem(
              icon: Icon(Icons.bluetooth_searching),
              label: 'Seriell',
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'Information',
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
