import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Hello jsw",
        home: DefaultTabController(
            length: 1,
            child: Scaffold(
                appBar: AppBar(
                  bottom: TabBar(
                    tabs: [
                      Tab(text: "Hello AppBar")
                    ],
                  ),
                ),
                body: TabBarView(
                    children: [
                      Tab1_View(),
                    ]
                )
            )
        )
    );
  }
}
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