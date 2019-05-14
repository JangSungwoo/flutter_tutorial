import "package:flutter/material.dart";

void main()=> runApp(new todo_list());

class todo_list extends StatelessWidget{
  @override
  Widget build(BuildContext ctxt) {
    return new Center(
      child: Text(
        "Hello Todo list base",
        textDirection: TextDirection.ltr,
      ),
    );
  }
}

