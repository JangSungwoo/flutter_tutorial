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
              Text('Hello jsw  '),
              Text('Hello ksg  '),
              Icon(
                Icons.android,
                size:50,
                color: Colors.red,
              ),

              Image.network(
                "https://cdn.arstechnica.net/wp-content/uploads/2018/02/7-2.jpg",
                width:200,
                height:100,
              ),
            ]
          )
          )
        ),
      );
  }
}