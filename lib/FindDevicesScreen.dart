// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:htl_led/DeviceScreen.dart';

StreamController<bool> streamController = StreamController();

class FindDevicesScreen extends StatefulWidget {
  const FindDevicesScreen({Key? key}) : super(key: key);

  @override
  _FindDevicesScreen createState() => new _FindDevicesScreen();
}

class _FindDevicesScreen extends State<FindDevicesScreen> {
  FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;

  @override
  void initState() {
    super.initState();
    print("jnasdljfnaksd");
    getPairedDevices();
  }

  bool isDisconnecting = false;
  @override
  void dispose() {
    super.dispose();
  }

  List<BluetoothDevice> _devicesList = [];

  Future<void> getPairedDevices() async {
    List<BluetoothDevice> devices = [];

    try {
      devices = await _bluetooth.getBondedDevices();
    } on PlatformException {
      print("Error");
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _devicesList = devices;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      //is used to make the widget refreshable
      onRefresh: getPairedDevices,
      child: ListView.builder(
        itemCount: _devicesList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_devicesList[index].name.toString()),
            subtitle: Text(_devicesList[index].address.toString()),
            trailing: ElevatedButton(
              child: const Text('Verbinden'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DeviceScreen(
                      _devicesList[index],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
