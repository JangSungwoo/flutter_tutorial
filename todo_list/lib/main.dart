import "package:flutter/material.dart";

import 'package:todo_list/set_todo_page.dart';
/*
Navigator를 할때 등가 교환이 되어야 한다.
Context가 Wiget 전체를 감싸고 있다고 생각하면
Navigator를 통해서 Context에 MererialApp이 포함된 Widget과
Context에 Scaffold만 있는 위젯은 교환이 불가능 하다.
 */
void main() => runApp(new MaterialApp(title:"To-Do-List", home : todo_list(items: List<String>.generate(30, (i) => "Item $i"))));

class todo_list extends StatelessWidget{
  final List<String> items;
  int a=0;
  todo_list({Key key, @required this.items}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title:Text("To-Do-List"),
        ),
        body: Stack(
          children: <Widget>
            [
              Center(
                child: Opacity(
                  opacity:0.3,
                  child:new Image.asset(
                    'assets/todo.jpg',
                    width:500,
                    height:100,

                  )
                )
              ),

              ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${items[index]}'),
                );
              },
            ),

          ]
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => set_todo_page())
            );
          },
          child: Icon(Icons.add)
        ),ㅋ
      );
  }
}

class Second_page extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
          title: Text("Hello"),
      )
    );
  }
}