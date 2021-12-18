// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:htl_led/models/BluetoothManager.dart';
import 'models/globals.dart' as globals;

class Modus extends StatefulWidget {
  final BluetoothManager manager;

  const Modus(
    this.manager,
  );

  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Modus> {
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
    double deviceWidth = MediaQuery.of(context).size.width;
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
                      widget.manager.sendMessageToBluetooth(
                          "N " + globals.leds.toInt().toString());
                    },
                    decoration: const InputDecoration(labelText: 'LEDs'),
                  ),
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 150),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                child: Row(
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        if (widget.manager.isTime()) {
                          setState(() {
                            if (!(_selectedMode == 0))
                              _selectedMode--;
                            else
                              _selectedMode = modes.length - 1;
                          });
                          widget.manager.sendMessageToBluetooth(
                              "M " + (_selectedMode + 1).toString());
                        }
                      },
                      child: const Icon(Icons.arrow_left),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.grey),
                      ),
                    ),
                    Image.network(
                      modes[_selectedMode][0],
                      width: deviceWidth / 2,
                      fit: BoxFit.contain,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (widget.manager.isTime()) {
                          setState(() {
                            if (!(_selectedMode == (modes.length - 1)))
                              _selectedMode++;
                            else
                              _selectedMode = 0;
                          });
                          widget.manager.sendMessageToBluetooth(
                              "M " + (_selectedMode + 1).toString());
                        }
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
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(50, 20, 50, 0),
                      child: Column(
                        children: [
                          const Text('Geschwindigkeit'),
                          Slider(
                            value: globals.v,
                            onChanged: (newRating) {
                              setState(() => globals.v = newRating);
                            },
                            onChangeEnd: (value) {
                              if (widget.manager.isTime()) {
                                widget.manager.sendMessageToBluetooth(
                                    "A " + globals.v.toInt().toString());
                              }
                            },
                            activeColor: Colors.green,
                            label: "${globals.v}",
                            min: 0,
                            max: 255,
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    )
                  : Row()
            ],
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
