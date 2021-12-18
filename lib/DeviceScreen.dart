// ignore_for_file: file_names, use_key_in_widget_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:htl_led/Modus.dart';
import 'package:htl_led/RGB.dart';
import 'package:htl_led/models/BluetoothManager.dart';

StreamController<bool> streamController = StreamController();

class DeviceScreen extends StatefulWidget {
  final BluetoothDevice device;

  const DeviceScreen(this.device);

  method() => createState().onItemTapped(0);
  @override
  _DeviceScreenState createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  late BluetoothManager bl;

  int _selectedIndex = 1;

  bool _isConnecting = true;
  bool isConnected = false;
  List<Widget> _children = [];
  @override
  void initState() {
    super.initState();
    bl = BluetoothManager(widget.device);

    _children.add(RGB(bl));
    _children.add(Modus(bl));

    BluetoothConnection.toAddress(bl.getAddress()).then((connection) {
      bl.setConnection(connection);
      setState(() {
        _isConnecting = false;
        isConnected = bl.getConnection()!.isConnected;
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected) {
      bl.getConnection()!.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (_isConnecting
            ? Text('Connecting to ' + widget.device.name.toString() + '...')
            : isConnected
                ? Text('Connected with ' + widget.device.name.toString())
                : Text('Disconnected from ' + widget.device.name.toString())),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _children,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.colorize_outlined),
            label: 'RGB',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_to_photos_outlined),
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
