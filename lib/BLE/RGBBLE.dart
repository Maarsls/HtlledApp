// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:htl_led/models/BluetoothManagerBLE.dart';
import '../models/globals.dart' as globals;

class RGBBLE extends StatefulWidget {
  final BluetoothManagerBLE manager;

  const RGBBLE(
    this.manager,
  );

  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<RGBBLE> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: Padding(
                  child: SpinBox(
                    min: 0,
                    max: 30,
                    value: globals.leds,
                    onChanged: (value) {
                      setState(() {
                        globals.leds = value;
                      });
                      widget.manager
                          .sendMessage("B " + globals.leds.toInt().toString());
                    },
                    decoration: const InputDecoration(labelText: 'LEDs'),
                  ),
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 150),
                ),
              ),
            ],
          ),
          const Text('RED'),
          Slider(
            value: globals.r,
            onChangeEnd: (newRating) {
              widget.manager.sendMessage("A " + globals.r.toInt().toString());
            },
            onChanged: (value) => setState(() => globals.r = value),
            activeColor: Colors.red,
            label: "${globals.r}",
            min: 0,
            max: 255,
          ),
          const Text('GREEN'),
          Slider(
            value: globals.g,
            onChangeEnd: (newRating) {
              widget.manager.sendMessage("B " + globals.g.toInt().toString());
            },
            onChanged: (value) => setState(() => globals.g = value),
            activeColor: Colors.green,
            label: "${globals.g}",
            min: 0,
            max: 255,
          ),
          const Text('BLUE'),
          Slider(
            value: globals.b,
            onChangeEnd: (newRating) {
              widget.manager.sendMessage("C " + globals.b.toInt().toString());
            },
            onChanged: (value) => setState(() => globals.b = value),
            activeColor: Colors.blue,
            label: "${globals.b}",
            min: 0,
            max: 255,
          )
        ],
      ),
    );
  }
}
