import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:htl_led/BluetoothOffScreen.dart';
import 'package:htl_led/DeviceChange.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.lightBlue,
      home: StreamBuilder<BluetoothState>(
          stream: FlutterBlue.instance.state,
          initialData: BluetoothState.unknown,
          builder: (c, snapshot) {
            final state = snapshot.data;
            if (state == BluetoothState.on) {
              return const DeviceChange();
            }
            return BluetoothOffScreen(state: state);
          }),
    );
  }
}
