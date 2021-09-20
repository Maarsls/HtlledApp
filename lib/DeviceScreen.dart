// ignore_for_file: file_names

import 'dart:async';
import 'dart:convert';

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

  String _messageBuffer = '';

  int _selectedIndex = 0;

  bool _isDisconnecting = false;
  bool _isConnecting = true;
  late bool isConnected;
  List<Widget> _children = [];
  @override
  void initState() {
    super.initState();
    bl = new BluetoothManager(widget.device);

    _children.add(RGB(bl));
    _children.add(Modus(bl));

    BluetoothConnection.toAddress(bl.getAddress()).then((connection) {
      print('Connected to the device');
      bl.setConnection(connection);
      _isConnecting = false;
      _isDisconnecting = false;
      isConnected = bl.getConnection().isConnected;
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    //if (isConnected) {
    _isDisconnecting = true;
    bl.getConnection().dispose();
    //}

    super.dispose();
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

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
