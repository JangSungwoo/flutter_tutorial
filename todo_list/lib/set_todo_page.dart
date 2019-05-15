import "package:flutter/material.dart";

import 'package:intl/intl.dart';

class set_todo_page extends StatelessWidget{

  DatePicker datePicker = new DatePicker();
  DateTime _date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
          Text(
            "Set Todo",
            style: new TextStyle(
            ),
          ),
        ),
      body: Container(
        margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
       child:Column(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            alignment: Alignment.bottomLeft,
            child:Text(
              "Todo",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
          TextField(

              keyboardType: TextInputType.multiline,
              maxLines: 5,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Input Todo'
            ),
              style: new TextStyle(
                  fontSize: 20.0,
                  height: 1.0,
                  color: Colors.black
              )
          ),
          Text(
            "Deadline",
            style: TextStyle(
                fontSize: 30
            ),
          ),
          FlatButton(
            onPressed: (){
             _date = datePicker.information(context);
             print(new DateFormat.yMMMd().format(new DateTime.now()));
            },
            child: Text(
                DateFormat.yMMMd().format(_date).toString()
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
          child:RaisedButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child:
            Text(
                "OK",
            ),
          ),
          ),
        ],
      )
      )
    );
  }
}
class DatePicker{
  information(BuildContext context){
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );
  }
}


class dDatePicker extends StatefulWidget {
  @override
  _DatePicker createState() => new _DatePicker();
}

//State is information of the application that can change over time or when some actions are taken.
class _DatePicker extends State<dDatePicker>{

  String _value = '';

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2019)
    );
    if(picked != null) setState(() => _value = picked.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: new Center(
          child: new Column(
            children: <Widget>[
              new RaisedButton(
                onPressed: _selectDate,
                child: new Text('Click me'),
              )
            ],
          ),
        ),
    );
  }
}
