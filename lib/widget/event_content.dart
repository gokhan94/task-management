import 'package:flutter/material.dart';
import 'package:task_management/model/event.dart';

class EventContent extends StatefulWidget {
  final Event event;
  const EventContent({
    Key? key, required this.event,
  }) : super(key: key);

  @override
  _EventContentState createState() => _EventContentState();
}

class _EventContentState extends State<EventContent> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 10),
          child: Container(
            child: Text(widget.event.description.toString(),
                style: TextStyle(
                    height: 1.4, fontSize: 19, color: Colors.black87)),
          ),
        ),
      ),
    );
  }
}