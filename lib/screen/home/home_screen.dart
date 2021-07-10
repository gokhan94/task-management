import 'package:flutter/material.dart';
import 'package:task_management/screen/navbar/navbar.dart';
import 'package:task_management/widget/category_list.dart';
import 'package:task_management/widget/event_list.dart';
import 'package:task_management/widget/tasks.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildAddTask(),
            CategoryList(),
            buildTodayTasks(),
            EventList(),
            Tasks(),
          ],
        ),
      ),
      bottomNavigationBar: Navbar(),
    );
  }

  Container buildTodayTasks() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Text("Today Tasks",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w900,
                fontSize: 24)));
  }

  Container buildAddTask() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          Text(
            "Today",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w900, fontSize: 24),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "April 12, 2021",
            style: TextStyle(
                color: Colors.grey.shade900,
                fontWeight: FontWeight.w400,
                fontSize: 14),
          ),
          Spacer(),
          TextButton.icon(
              label: Text(
                'Create New Task',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.teal.shade600,
                primary: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                elevation: 10,
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              icon: Icon(
                Icons.add,
                size: 16,
              ),
              onPressed: () {})
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: Icon(
        Icons.menu,
        color: Colors.grey.shade600,
        size: 25,
      ),
      elevation: 0,
      title: Text(
        "TODOS",
        style: TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
            fontSize: 25),
      ),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.push_pin_outlined,
              color: Colors.grey.shade600,
              size: 25,
            )),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search_rounded,
              color: Colors.grey.shade700,
              size: 25,
            )),
      ],
    );
  }
}
