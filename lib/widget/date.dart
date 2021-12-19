import 'package:flutter/material.dart';
import 'package:task_management/model/event.dart';

class Date extends StatefulWidget {
  final Event event;
  const Date({
    Key? key, required this.event,
  }) : super(key: key);

  @override
  _DateState createState() => _DateState();
}

class _DateState extends State<Date> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(left: 25, right: 40),
            child: Text("Date",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black87)),
          ),
          Expanded(
            child: Text(widget.event.date.toString() + " - " + widget.event.time.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 19,
                    color: Colors.black54)),
          ),
        ],
      ),
    );
  }
}