import 'package:flutter/material.dart';
import 'package:flutter_app/tabs/tab1.dart';
import  'package:flutter_app/tabs/tab2_switch.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Hello jsw",
        home: DefaultTabController(
            length: 3,
            child: Scaffold(
                appBar: AppBar(
                  bottom: TabBar(
                    tabs: [
                      Tab(text: "Hello AppBar"),
                      Tab(icon: Icon(Icons.home)),
                      Tab(icon: Icon(Icons.warning))

                    ],
                  ),
                ),
                body: TabBarView(
                    children: [
                      Tab1_View(),//tabs/tab1
                      Tab2_switch(), //tab/tab2_switch
                      Icon(Icons.warning),

                    ]
                )
            )
        )
    );
  }
}
