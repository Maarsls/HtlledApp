// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:htl_led/models/BluetoothManager.dart';

class RGB extends StatefulWidget {
  final BluetoothManager manager;

  const RGB(
    this.manager,
  );

  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<RGB> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var red = 0.0;
    var green = 0.0;
    var blue = 0.0;
    return Center(
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: Padding(
                  child: SpinBox(
                    value: 10,
                    decoration: const InputDecoration(labelText: 'LEDs'),
                  ),
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 200),
                ),
              ),
            ],
          ),
          const Text('RED'),
          Slider(
            value: red,
            onChanged: (newRating) {
              setState(() => red = newRating);
            },
            activeColor: Colors.red,
            label: "$red",
            min: 0,
            max: 255,
          ),
          const Text('GREEN'),
          Slider(
            value: green,
            onChanged: (newRating) {
              setState(() => green = newRating);
            },
            activeColor: Colors.green,
            label: "$green",
            min: 0,
            max: 255,
          ),
          const Text('BLUE'),
          Slider(
            value: blue,
            onChanged: (newRating) {
              setState(() => blue = newRating);
            },
            activeColor: Colors.blue,
            label: "$blue",
            min: 0,
            max: 255,
          )
        ],
      ),
    );
  }
}
