// ignore_for_file: file_names

import 'dart:async';
import 'dart:convert';

import 'package:flutter_blue/flutter_blue.dart';

class BluetoothManagerBLE {
  BluetoothDevice? _device;
  late BluetoothCharacteristic? c;
  bool isWritable = true;
  int sinceLastWrite = 0;

  BluetoothManagerBLE(BluetoothDevice device) {
    _device = device;
    _establishConnection();
  }

  BluetoothDevice? getDevice() {
    return _device;
  }

  void _establishConnection() {
    _device!.connect().then((value) async {
      _findCharacteristic().then((value) {
        c = value;
      });
    });
  }

  void dispose() {
    _device!.disconnect();
  }

  Future<BluetoothCharacteristic?> _findCharacteristic() async {
    BluetoothCharacteristic? foundCharacteristic = null;
    List<BluetoothService> services = await _device!.discoverServices();
    services.forEach((service) {
      if (service.uuid.toString() == "0000ffe0-0000-1000-8000-00805f9b34fb") {
        for (BluetoothCharacteristic c in service.characteristics) {
          print(c.properties);
          if (c.properties.writeWithoutResponse) {
            print(c.properties);
            foundCharacteristic = c;
            break;
          }
        }
      }
    });
    return foundCharacteristic;
  }

  Future<void> sendMessage(String message) async {
    print("iwrite");
    //await c!.write([0x12, 0x34]);
    /*Timer(Duration(seconds: 1), (){

    });*/
    if (isTime())
      await c!.write(utf8.encode(message + "\n")).then(
          (value) => sinceLastWrite = DateTime.now().millisecondsSinceEpoch);
  }

  bool isTime() {
    if (DateTime.now().millisecondsSinceEpoch > sinceLastWrite + 1000)
      return true;

    return false;
  }
}
