import 'package:flutter/material.dart';
import 'package:task_management/auth/auth_service.dart';
import 'package:task_management/screen/navbar/nav_item.dart';
import 'package:task_management/screen/profile/profile_screen.dart';
import 'package:task_management/widget/all_todos.dart';
import 'package:task_management/widget/single_event.dart';
import 'package:task_management/widget/todo.dart';
import 'package:provider/provider.dart';

class Navbar extends StatelessWidget {
  const Navbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userId = context.read<AuthenticationService>().getCurrentUID;
    return Container(
      color: Colors.white70,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NavItem(
              icon: Icon(Icons.title),
              title: "My Todo",
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Todo(userId: userId);
                }));
              },
            ),
            NavItem(
              icon: Icon(Icons.list),
              title: "All Todo",
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AllTodos(userId: userId)),);

              },
            ),
            NavItem(
              icon: Icon(Icons.event_note),
              title: "My Events",
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UserEventSingle(userId: userId)),);
              },
            ),
            NavItem(
              icon: Icon(Icons.settings),
              title: "Profile",
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(userId: userId)),);
              },
            ),
          ],
        ),
      ),
    );
  }
}