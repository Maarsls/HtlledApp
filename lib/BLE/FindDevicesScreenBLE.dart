// ignore_for_file: file_names

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
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
    widget.flutterBlue.startScan();
  }

  @override
  void dispose() {
    super.dispose();
    widget.flutterBlue.stopScan();
  }

  ListView _buildListViewOfDevices() {
    List<ListTile> containers = [];
    for (BluetoothDevice device in widget.devicesList) {
      if (device.name.toString().length > 2) {
        containers.add(ListTile(
          title: Text(device.name.toString()),
          subtitle: Text(device.id.toString()),
          trailing: ElevatedButton(
            child: const Text('Verbinden'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DeviceScreenBLE(
                    device: device,
                  ),
                ),
              );
            },
          ),
        ));
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
