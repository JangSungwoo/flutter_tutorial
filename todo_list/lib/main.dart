import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todolist1/todo_list/todo_class.dart';

import 'package:sqflite/sqflite.dart';

import 'dart:async';
import 'package:path/path.dart';
import 'package:intl/intl.dart';

import 'package:firebase_admob/firebase_admob.dart';

void main() async {
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

  MyApp(var items, var db) {
    this.items = items;
    this.db = db;
  }

  Widget build(BuildContext context) {
    InitAdMob();
    return new MaterialApp(
      title: 'ToDo List',
      color: Colors.red,
      home: MyPage(items, db),
      builder: (BuildContext context, Widget widget) {
        final mediaQuery = MediaQuery.of(context);
        return new Padding(
          child: widget,
          padding: new EdgeInsets.only(bottom: getSmartBannerHeight(mediaQuery)),
        );
      },
    );
  }

  double getSmartBannerHeight(MediaQueryData mediaQuery) {
    // https://developers.google.com/admob/android/banner#smart_banners
    if (Platform.isAndroid) {
      if (mediaQuery.size.height > 720) return 90.0;
      if (mediaQuery.size.height > 400) return 50.0;
      return 32.0;
    }
    // https://developers.google.com/admob/ios/banner#smart_banners
    // Smart Banners on iPhones have a height of 50 points in portrait and 32 points in landscape.
    // On iPads, height is 90 points in both portrait and landscape.
    if (Platform.isIOS) {
      // TODO use https://pub.dartlang.org/packages/device_info to detect iPhone/iPad?
      // if (iPad) return 90.0;
      if (mediaQuery.orientation == Orientation.portrait) return 50.0;
      return 32.0;
    }
    // No idea, just return a common value.
    return 50.0;
  }
  InitAdMob() {
    String appId = "ca-app-pub-5693835159760507~9860897860";
    String myBannerId="ca-app-pub-5693835159760507/4225427806";
    String TestDeviceId="DC0EF7D843685BD59F2409F0E83F85FA";//JSW
    FirebaseAdMob.instance.initialize(appId: appId);

    MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      keywords: <String>['flutterio', 'beautiful apps'],
      contentUrl: 'https://flutter.io',
      childDirected: false,
      testDevices: <String>[TestDeviceId], // Android emulators are considered test devices
    );

    BannerAd myBanner = BannerAd(
      // Replace the testAdUnitId with an ad unit id from the AdMob dash.
      // https://developers.google.com/admob/android/test-ads
      // https://developers.google.com/admob/ios/test-ads
      adUnitId: myBannerId,
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      },
    );
    myBanner
    // typically this happens well before the ad is shown
      ..load()
      ..show(
        // Positions the banner ad 60 pixels from the bottom of the screen
        anchorOffset: 0.0,
        // Banner Position
        anchorType: AnchorType.bottom,
      );
  }
}

class MyPage extends StatefulWidget {
  @override
  List<todo_item> items;
  DB db;

  MyPage(var items, var db) {
    this.items = items;
    this.db = db;
  }

  MyPageState createState() => new MyPageState(items, db);
}

class MyPageState extends State<MyPage> {
  List<todo_item> items;
  DB db;

  MyPageState(var items, var db) {
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
      body: Container(
          child: Column(children: <Widget>[
            Expanded(
              child: Todo_list_body(items, db),
            ),
          ])),
      floatingActionButton: FloatingActionButton(
        child: Icon(
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
      var num = 0;
      for (int i = 0; i < len; i++) {
        if (items[num].todo_icon == Icons.check_box) {
          items.removeAt(num);
        } else {
          num++;
        }
      }
    });
  }

  void _onFABbutton(context) {
    TextEditingController text_controller = TextEditingController();
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(children: <Widget>[
            Text(
              "Make Todo list",
            ),
            TextFormField(
              controller: text_controller,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'what are you have to do?\n\n'),
              maxLines: 3,
              autofocus: true,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (text) =>
                  _onFieldSubmitted(text_controller, context),
            )
          ]);
        });
  }

  void _onFieldSubmitted(var text_controller, var context) async {
    Navigator.pop(context);
    String now = DateFormat('yyyy-MM-dd - kk:mm').format(DateTime.now());
    String todo_val = text_controller.text;
    setState(() {
      items.add(todo_item(Icons.check_box_outline_blank, todo_val, now));
    });
    var num = items.length;
    Todo value = Todo(id: num, todo: todo_val, time: now, complete: 0);
    await db.insertTodo(value);

    print(await db.todos());
  }
}

class Todo_list_body extends StatefulWidget {
  List<todo_item> items;
  DB db;

  Todo_list_body(var items, var db) {
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
    for (var value in val) {
      if (value.complete == 1) {
        icon = Icons.check_box;
      } else {
        icon = Icons.check_box_outline_blank;
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
          complete: maps[i]['complete']);
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
      {'complete': comp}, // 업데이트할 값
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
