import 'package:flutter/material.dart';

class Tab2_switch extends StatelessWidget{

  bool _value1 = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Switch(value: _value1, onChanged: null),
        )
      )
    );
  }
}