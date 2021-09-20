// ignore_for_file: file_names

import 'package:flutter/material.dart';
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
        children: <Widget>[
          ElevatedButton(
            onPressed: () => _showAutonom(),
            child: Text("Autonom fahren"),
          ),
          ElevatedButton(
            onPressed: () => widget.manager.sendMessageToBluetooth("C"),
            child: Text("selbst steuern"),
          )
        ],
      ),
    );
  }

  Future<void> _showAutonom() async {
    //widget.m.method();
    //widget.manager.sendMessageToBluetooth("C");
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Du fährst nun autonom'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Willst du wieder selbst steuren,'),
                Text('dann klicke unten auf Steuerung'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('verstanden'),
              onPressed: () {
                Navigator.pop(context);
                widget.manager.sendMessageToBluetooth("C");
              },
            ),
          ],
        );
      },
    );
  }
}
