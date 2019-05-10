
import 'package:flutter/material.dart';

class Tab1_View extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Text('Hello jsw  '),
          Text('Hello ksg  '),
          Icon(
            Icons.android,
            size: 50,
            color: Colors.red,
          ),

          Image.network(
            "https://cdn.arstechnica.net/wp-content/uploads/2018/02/7-2.jpg",
            width: 200,
            height: 100,
          ),
          Image.asset(
              "assets/flutter.png",
              color: Colors.red
          )
        ]
    );
  }
}