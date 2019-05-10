import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hello jsw",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Hello AppBar"),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text('Hello jsw'),
              Text('Hello ksg'),
            ]
          )
          )
        ),
      );
  }
}