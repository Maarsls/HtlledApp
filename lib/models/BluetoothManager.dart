// ignore_for_file: file_names

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothManager {
  String? _address;
  BluetoothConnection? _connection;
  bool? _isConnecting;
  bool? _isDisconnecting;
  BluetoothDevice? _device;
  int sinceLastWrite = 0;

  BluetoothManager(BluetoothDevice device) {
    _address = device.address;
    _isConnecting = true;
    _device = device;
  }

  BluetoothDevice? getDevice() {
    return _device;
  }

  void sendMessageToBluetooth(String data) async {
    if (isTime()) {
      _connection!.output.add(Uint8List.fromList(utf8.encode(data + "\r\n")));
      await _connection!.output.allSent.then(
          (value) => sinceLastWrite = DateTime.now().millisecondsSinceEpoch);
    }
  }

  bool isTime() {
    if (DateTime.now().millisecondsSinceEpoch > sinceLastWrite + 1000)
      return true;

    return false;
  }

  void setConnection(BluetoothConnection connection) {
    _connection = connection;
    _isConnecting = false;
  }

  BluetoothConnection? getConnection() {
    return _connection;
  }

  bool? getIsConnecting() {
    return _isConnecting;
  }

  bool? getIsDisconnecting() {
    return _isDisconnecting;
  }

  String? getAddress() {
    return _address;
  }
}
