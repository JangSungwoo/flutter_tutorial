import 'package:flutter/material.dart';
import 'package:flutter_app/tabs/tab1.dart';
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
                      Tab1_View(),//tabs/tab1
                    ]
                )
            )
        )
    );
  }
}
