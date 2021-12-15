// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:htl_led/models/BluetoothManagerBLE.dart';
import '../models/globals.dart' as globals;

class ModusBLE extends StatefulWidget {
  final BluetoothManagerBLE manager;

  const ModusBLE(
    this.manager,
  );

  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<ModusBLE> {
  List<List<String>> modes = [];
  int _selectedMode = 0;

  @override
  void initState() {
    super.initState();

    modes.add(["https://api.htlled.at/api/gif/muster0.gif", "false"]);
    modes.add(["https://api.htlled.at/api/gif/muster1.gif", "false"]);
    modes.add(["https://api.htlled.at/api/gif/muster2.gif", "true"]);
    modes.add(["https://api.htlled.at/api/gif/muster3.gif", "true"]);
    modes.add(["https://api.htlled.at/api/gif/muster4.gif", "true"]);
    modes.add(["https://api.htlled.at/api/gif/muster5.gif", "true"]);
    modes.add(["https://api.htlled.at/api/gif/muster6.gif", "true"]);
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
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
            child: Row(
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (!(_selectedMode == 0))
                        _selectedMode--;
                      else
                        _selectedMode = modes.length - 1;
                    });
                    widget.manager
                        .sendMessage("M " + (_selectedMode + 1).toString());
                  },
                  child: const Icon(Icons.arrow_left),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.grey),
                  ),
                ),
                Image.network(
                  modes[_selectedMode][0],
                  width: 200,
                  fit: BoxFit.contain,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (!(_selectedMode == (modes.length - 1)))
                        _selectedMode++;
                      else
                        _selectedMode = 0;
                    });
                    widget.manager
                        .sendMessage("M " + (_selectedMode + 1).toString());
                  },
                  child: const Icon(Icons.arrow_right),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.grey),
                  ),
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
          (modes[_selectedMode][1] == 'true')
              ? Row(
                  children: [
                    const Text('Geschwindigkeit'),
                    Slider(
                      value: globals.v,
                      onChanged: (newRating) {
                        setState(() => globals.v = newRating);
                      },
                      onChangeEnd: (value) {
                        widget.manager
                            .sendMessage("A " + globals.v.toInt().toString());
                      },
                      activeColor: Colors.green,
                      label: "${globals.v}",
                      min: 0,
                      max: 255,
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                )
              : Row()
        ],
      ),
    );
  }
}
