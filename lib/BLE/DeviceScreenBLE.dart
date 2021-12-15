// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:htl_led/BLE/ModusBLE.dart';
import 'package:htl_led/BLE/RGBBLE.dart';
import 'package:htl_led/models/BluetoothManagerBLE.dart';

class DeviceScreenBLE extends StatefulWidget {
  const DeviceScreenBLE({Key? key, required this.device}) : super(key: key);

  final BluetoothDevice device;
  @override
  _DeviceScreenBLEState createState() => _DeviceScreenBLEState();
}

class _DeviceScreenBLEState extends State<DeviceScreenBLE> {
  late BluetoothManagerBLE bl;
  List<Widget> _children = [];
  int _selectedIndex = 1;
  BluetoothDeviceState _deviceState = BluetoothDeviceState.disconnected;

  @override
  void initState() {
    super.initState();
    bl = BluetoothManagerBLE(widget.device);

    widget.device.state.listen((event) {
      if (mounted)
        setState(() {
          _deviceState = event;
        });
    });

    _children.add(RGBBLE(bl));
    _children.add(ModusBLE(bl));
  }

  @override
  void dispose() {
    super.dispose();
    bl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: (_deviceState == BluetoothDeviceState.connected)
              ? Text("Verbunden mit ${widget.device.name}")
              : (_deviceState == BluetoothDeviceState.disconnected)
                  ? Text("${widget.device.name} nicht verbunden")
                  : Text("${widget.device.name} wird verbunden")),
      body: IndexedStack(
        index: _selectedIndex,
        children: _children,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.rotate_90_degrees_ccw),
            label: 'RGB',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.car_rental),
            label: 'Modus',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.yellow,
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
