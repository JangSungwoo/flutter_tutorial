import 'package:flutter/material.dart';
import 'package:todolist1/todo_list/todo_class.dart';

import 'package:sqflite/sqflite.dart';

import 'dart:async';
import 'package:path/path.dart';
import 'package:intl/intl.dart';

void main() async{

  final database = openDatabase(
      join(await getDatabasesPath(), 'todo_list.db'),
      onCreate: (db, version) {
        return db.execute(
        "CREATE TABLE todos(id INTEGER PRIMARY KEY, todo TEXT, time TEXT, complete INTEGER)",
        );
      },
      version: 1,
  );

  List<todo_item> items = [];
  DB db = DB(database);
  await db.load_todo_val(items);

  runApp(MyApp(items, db));
}

class MyApp extends StatelessWidget {
  @override
  DB db;
  List<todo_item> items;


  MyApp(var items, var db){
    this.items=items;
    this.db = db;
  }

  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'ToDo List',
      color: Colors.red,
      home: MyPage(items, db),
    );
  }
}

class MyPage extends StatefulWidget {
  @override
  List<todo_item> items;
  DB db;
  MyPage(var items, var db){
    this.items = items;
    this.db = db;
  }
  MyPageState createState() => new MyPageState(items, db);
}

class MyPageState extends State<MyPage> {

  List<todo_item> items;
  DB db;
  MyPageState(var items, var db){
    this.items = items;
    this.db = db;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ToDo List'),
          backgroundColor: Colors.red,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  //Delete check value
                  appBar_IconButton_action();
                  db.deleteTodoComp(1);
                }),
          ],
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child:Todo_list_body(items, db),
              ),
            ]
          )
        ),
        floatingActionButton:FloatingActionButton(
            child:Icon(
              Icons.add,
            ),
        backgroundColor: Colors.red,
        onPressed: () => _onFABbutton(context),
      ),
    );
  }

  void appBar_IconButton_action() {
    setState(() {
      var len = items.length;
      var num =0;
      for(int i=0; i<len;i++){
        if (items[num].todo_icon == Icons.check_box) {
          items.removeAt(num);
        }else{num++;}
      }
    });
  }

  void _onFABbutton(context) {
    TextEditingController text_controller = TextEditingController();
    showModalBottomSheet(context: context, builder: (context) {
      return Column(
          children: <Widget>[
            Text("Make Todo list",
              ),
            TextFormField(
              controller: text_controller,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'what are you have to do?\n\n'),
              maxLines: 3,
              autofocus: true,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (text) => _onFieldSubmitted(text_controller, context),
            )
            ]);
    });
  }

  void _onFieldSubmitted (var text_controller, var context) async{
    Navigator.pop(context);
    String now = DateFormat('yyyy-MM-dd - kk:mm').format(DateTime.now());
    String todo_val = text_controller.text;
    setState(() {
      items.add(todo_item(
          Icons.check_box_outline_blank, todo_val, now));
    }
    );
    var num = items.length;
    Todo value = Todo(id:num, todo:todo_val, time:now, complete: 0);
    await db.insertTodo(value);

    print(await db.todos());


  }
}

class Todo_list_body extends StatefulWidget {
  List<todo_item> items;
  DB db;
  Todo_list_body(var items, var db){
    this.items = items;
    this.db = db;
  }
  Todo_body createState() => Todo_body(items, db);
}

class Todo_body extends State<Todo_list_body> {
  List<todo_item> items = [];
  DB db;
  
  Todo_body(var items, var db) {
    this.items = items;
    this.db = db;
  }
  
  void complete_toggle(var index, var val) async {
    this.db.updateTodo_Comp(index, val);
  }

  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(items[index].todo_icon),
            title: Text(items[index].todo_title),
            subtitle: Text(items[index].todo_sub),
            onTap: () {
              setState(() {
                if (items[index].todo_icon == Icons.check_box_outline_blank) {
                  items[index].todo_icon = Icons.check_box;
                  complete_toggle(items[index].todo_title, 1);
                } else {
                  items[index].todo_icon = Icons.check_box_outline_blank;
                  complete_toggle(items[index].todo_title, 0);
                }
              });
            },
            onLongPress: () {},
          );
        });
  }
}




class Todo {
  final int id;
  final String todo;
  final String time;
  final int complete;

  Todo({this.id, this.todo, this.time, this.complete});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'todo': todo,
      'time': time,
      'complete': complete,
    };
  }
}


class DB {
  Future<Database> db;

  DB(Future<Database> db) {
    this.db = db;
  }

  Future<void> load_todo_val(List<todo_item> todo_list) async {
    List<Todo> val = await todos();
    var icon;
    for(var value in val){
      if(value.complete == 1){
        icon=Icons.check_box;
      }else{
        icon=Icons.check_box_outline_blank;
      }
      todo_list.add(todo_item(icon, value.todo, value.time));
    }
  }

  Future<void> insertTodo(Todo todo) async {
    final Database db = await this.db;
    await db.insert(
      'todos', //DB table 이름
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Todo>> todos() async {
    final Database db = await this.db;

    final List<Map<String, dynamic>> maps = await db.query('todos');
    return List.generate(maps.length, (i) {
      return Todo(
          id: maps[i]['id'],
          todo: maps[i]['todo'],
          time: maps[i]['time'],
          complete: maps[i]['complete']
      );
    });
  }

  Future<void> updateTodo(Todo todo) async {
    final db = await this.db;

    await db.update(
      'todos', //DB table 이름
      todo.toMap(), // 업데이트할 값
      where: "id=?",
      whereArgs: [todo.id],
    );
  }

  Future<void> updateTodo_Comp(String todo_val, int comp) async {
    final db = await this.db;

    await db.update(
      'todos', //DB table 이름
      {'complete':comp}, // 업데이트할 값
      where: "todo=?",
      whereArgs: [todo_val],
    );
  }

  Future<void> deleteTodoid(int id) async {
    final db = await this.db;
    await db.delete(
      'todos',
      where: "id=?",
      whereArgs: [id],
    );
  }

  Future<void> deleteTodoComp(int comp) async {
    final db = await this.db;
    await db.delete(
      'todos',
      where: "complete=?",
      whereArgs: [comp],
    );
  }


}
