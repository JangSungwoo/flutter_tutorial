import "package:flutter/material.dart";

import 'package:intl/intl.dart';

class set_todo_page extends StatefulWidget{
  @override
  _set_todo_page createState() => new _set_todo_page();
}
class _set_todo_page extends State<set_todo_page>{

  DatePicker datePicker = new DatePicker();
  DateTime selectedDate = DateTime.now();
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
          Center(
          child:DatePicker2(),
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

class DatePicker2 extends StatefulWidget {

  @override
  _DatePicker2 createState() => new _DatePicker2();
}

class _DatePicker2 extends State<DatePicker2>{
  DateTime selectedDate = DateTime.now();
  final DateFormat dateFormat = DateFormat('MM-dd HH:mm');

  @override
  Widget build(BuildContext context) {
    return Row(
      children:<Widget>[
        Text(dateFormat.format(selectedDate)),
        FlatButton(
          onPressed: () async {
            final selectedDate = await _selectDate(context);
            final selectedTime = await _selectTime(context);
            setState(() {
              this.selectedDate = DateTime(
                selectedDate.year,
                selectedDate.month,
                selectedDate.day,
                selectedTime.hour,
                selectedTime.minute,
              );
            });
            },
          child: Image.asset(
            'assets/baseline_event_black_48dp.png',
            height: 30,
          ),
          color: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
      ]
    );
  }

  Future<TimeOfDay> _selectTime(BuildContext context){
    final now = DateTime.now();

    return showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
    );
  }
  Future<DateTime> _selectDate(BuildContext context) =>
      showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2030),
      );
}
