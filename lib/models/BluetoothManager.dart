// ignore_for_file: file_names

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothManager {
  late String _address;
  late BluetoothConnection _connection;
  late bool _isConnecting;
  late bool _isDisconnecting;
  late BluetoothDevice _device;

  BluetoothManager(BluetoothDevice device) {
    _address = device.address;
    _isConnecting = true;
    _device = device;
  }

  BluetoothDevice getDevice() {
    return _device;
  }

  void sendMessageToBluetooth(String data) async {
    _connection.output.add(Uint8List.fromList(utf8.encode(data + "\r\n")));
    await _connection.output.allSent;
  }

  void setConnection(BluetoothConnection connection) {
    _connection = connection;
    _isConnecting = false;
  }

  BluetoothConnection getConnection() {
    return _connection;
  }

  bool getIsConnecting() {
    return _isConnecting;
  }

  bool getIsDisconnecting() {
    return _isDisconnecting;
  }

  String getAddress() {
    return _address;
  }
}
