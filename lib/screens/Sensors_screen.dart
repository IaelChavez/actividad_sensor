import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

class AccelerometerScreen extends StatefulWidget {
  @override
  _AccelerometerScreenState createState() => _AccelerometerScreenState();
}

class _AccelerometerScreenState extends State<AccelerometerScreen> {
  late StreamSubscription _streamSubscription;
  int _stepCount = 0;
  Color _backgroundColor = Colors.blue;
  var pokemon =
      "assets/images/Pikachu.png";

  @override
  void initState() {
    super.initState();
    _streamSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        if (event.x > 11.0) {
          _stepCount++;
        }
        _changeEverything();
      });
    });
  }

  void _changeEverything() {
    setState(() {
      if (_stepCount > -1 && _stepCount < 10) {
        _backgroundColor = Colors.green;
        pokemon = "assets/images/Pikachu.png";

      } else if (_stepCount > 10 && _stepCount < 20) {
        _backgroundColor = Colors.yellow;
        pokemon = "assets/images/pikachu_sentado.png";

      } else if (_stepCount > 20) {
        _backgroundColor = Colors.red;
        pokemon = "assets/images/Pikachu_Sleeping.png";
      }
    });
  }

  void _resetPokemon() {
    setState(() {
      _stepCount = 0;
    });
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sensor de movimiento'),
        ),
        body: Container(
          color: _backgroundColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Pasos: ${_stepCount}',
                  style: TextStyle(fontSize: 24.0),
                ),
                SizedBox(height: 16.0),
                Image.asset(
                  pokemon,
                  width: 200.0,
                  height: 200.0,
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  child: Text("Reiniciar"),
                  onPressed: _resetPokemon,
                ),
              ],
            ),
          ),
        ));
  }
}
