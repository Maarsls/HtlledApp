// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:htl_led/RGB.dart';
import 'package:htl_led/models/BluetoothManager.dart';

class Modus extends StatefulWidget {
  final BluetoothManager manager;

  const Modus(
    this.manager,
  );

  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Modus> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  child: SpinBox(
                    value: 10,
                    decoration: const InputDecoration(labelText: 'LEDs'),
                  ),
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 150),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              ElevatedButton(
                onPressed: () {},
                child: const Icon(Icons.arrow_left),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.grey),
                ),
              ),
              Image.network(
                'https://flutter-examples.com/wp-content/uploads/2021/01/happy_mothers_Day.gif',
                width: 220,
                fit: BoxFit.contain,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Icon(Icons.arrow_right),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.grey),
                ),
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      ),
    );
  }
}
