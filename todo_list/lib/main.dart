import "package:flutter/material.dart";

void main() {

  runApp(new todo_list(
    items: List<String>.generate(30, (i) => "Item $i"),
  ));
}

class todo_list extends StatelessWidget{
  final List<String> items;
  int a=0;
  todo_list({Key key, @required this.items}) : super(key: key);

  @override

  Widget build(BuildContext ctxt) {
    return new MaterialApp(
      title:"To-Do-List",
      home:Scaffold(
        appBar: AppBar(
          title:Text("To-Do-List"),
        ),
        body: Stack(
          children: <Widget>
            [
              Center(
                child: new Image.asset(
                  'assets/todo.jpg',
                  width:500,
                  height:100,
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
            a=a+1;
            print(a);
          },
          child: Icon(Icons.add)
        ),
      ),
    );
  }
}

