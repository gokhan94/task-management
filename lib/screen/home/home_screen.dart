import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_management/auth/auth_service.dart';
import 'package:task_management/screen/add_category.dart';
import 'package:task_management/screen/event/event_add.dart';
import 'package:task_management/screen/navbar/navbar.dart';
import 'package:task_management/screen/tasks/add_tasks.dart';
import 'package:task_management/services/database.dart';
import 'package:task_management/widget/category_list.dart';
import 'package:task_management/widget/event_list.dart';
import 'package:task_management/widget/tasks.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  AuthenticationService authenticationService = AuthenticationService(FirebaseAuth.instance);
  FireStoreDatabase fireStoreDatabase = FireStoreDatabase();
  final format =  DateFormat('dd-MM-yyyy');
  bool? _admin;

  getAdmin() async {
    List<QueryDocumentSnapshot> admin = await fireStoreDatabase.isAdmin(authenticationService.getCurrentUID);
    for(DocumentSnapshot document in admin) {

      if(mounted){
        setState(() {
          _admin = document['isAdmin'];
        });
      }

    }
  }

  @override
  void initState() {
    super.initState();
    getAdmin();
  }

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
                buildAllEvents(),
                EventList(),
                Tasks(),
              ],
            ),
          ),
          bottomNavigationBar: Navbar(),
    );
  }

  Container buildAllEvents() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Text("Most Recently Added Events",
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
            format.format(DateTime.now()),
            style: TextStyle(
                color: Colors.grey.shade900,
                fontWeight: FontWeight.w400,
                fontSize: 15),
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
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddTask()),);
              })
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading:  IconButton(
          onPressed: ()  {
            Navigator.push(context, MaterialPageRoute(builder: (context) => EventAdd()),);
          },
          icon: Icon(
            Icons.event,
            color: Colors.grey.shade700,
            size: 25,
          )),
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
        _admin == true ?
        IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryAdd()),);
            },
            icon: Icon(
              Icons.add,
              color: Colors.grey.shade600,
              size: 25,
            )) : Text("no"),

        IconButton(
            onPressed: () async {
              await context.read<AuthenticationService>().signOut();

            },
            icon: Icon(
              Icons.logout,
              color: Colors.grey.shade700,
              size: 25,
            )),
      ],
    );
  }
}
