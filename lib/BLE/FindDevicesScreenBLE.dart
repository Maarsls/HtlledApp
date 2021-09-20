// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:htl_led/BLE/DeviceScreenBLE.dart';

class FindDevicesScreenBLE extends StatefulWidget {
  FindDevicesScreenBLE({Key? key}) : super(key: key);

  final FlutterBlue flutterBlue = FlutterBlue.instance;
  final List<BluetoothDevice> devicesList = [];

  @override
  _FindDevicesScreenState createState() => _FindDevicesScreenState();
}

class _FindDevicesScreenState extends State<FindDevicesScreenBLE> {
  void _getDeviceList() {
    widget.flutterBlue.startScan();
    print(widget.flutterBlue.scanResults);
/*List<ScanResult> _devices = [];

try {
      _devices = await widget.flutterBlue.scanResults;
    } on PlatformException {
      print("Error");
    }

    widget.flutterBlue.scanResults;

    if (!widget.devicesList.contains(device)) {
      setState(() {
        widget.devicesList.add(device);
      });
    }
  }

  _addDeviceTolist(final BluetoothDevice device) {
    if (!widget.devicesList.contains(device)) {
      setState(() {
        widget.devicesList.add(device);
      });
    }
  }

  @override
  void initState() {
    super.initState();

    widget.flutterBlue.Timer.periodic(Duration(seconds: 5), (Timer timer) {
      for (BluetoothDevice check in widget.devicesList) {}
    });

    widget.flutterBlue.connectedDevices
        .asStream()
        .listen((List<BluetoothDevice> devices) {
      for (BluetoothDevice device in devices) {
        _addDeviceTolist(device);
      }
    });
    widget.flutterBlue.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        _addDeviceTolist(result.device);
      }
    });
    widget.flutterBlue.startScan();*/
  }

  ListView _buildListViewOfDevices() {
    print("I build");
    List<Container> containers = [];
    for (BluetoothDevice device in widget.devicesList) {
      if (device.name.toString().length > 2) {
        containers.add(
          Container(
            height: 50,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(
                          device.name == '' ? '(unknown device)' : device.name),
                      Text(device.id.toString()),
                    ],
                  ),
                ),
                TextButton(
                  child: const Text('Verbinden'),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DeviceScreenBLE(device: device))),
                ),
              ],
            ),
          ),
        );
      }
    }

    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...containers,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildListViewOfDevices();
  }
}
