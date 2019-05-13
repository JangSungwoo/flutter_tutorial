import 'package:flutter/material.dart';

class Tab2_switch extends StatefulWidget{
  @override
  _State createState() => new _State();
}

class _State extends State<Tab2_switch>{

  bool _value1 = true;

  //Add Stateful Widget function
  void _OnChanged1(bool value) => setState(() => _value1 = value);

  /*
  void _OnChanged1(bool value) => setState(() => func(value));

  //Testing code
  //void func(value){
    _value1 = value;
    print(value);
  }
  */

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(
            padding: new EdgeInsets.all(32.0),
            child: new Center(
              child: new Switch(value: _value1, onChanged: _OnChanged1),
            )
        )
    );
  }
}