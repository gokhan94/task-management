import 'package:flutter/material.dart';
import 'package:task_management/screen/navbar/nav_item.dart';
import 'package:task_management/widget/todo.dart';

class Navbar extends StatelessWidget {
  const Navbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white70,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NavItem(
              icon: Icon(Icons.list_sharp),
              title: "My Todos",
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Todo();
                }));
              },
            ),
            NavItem(
              icon: Icon(Icons.access_alarm_outlined),
              title: "Calendar",
              press: () {},
            ),
            NavItem(
              icon: Icon(Icons.event),
              title: "Event",
              press: () {},
            ),
          ],
        ),
      ),
    );
  }
}