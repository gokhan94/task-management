import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_management/model/task.dart';
import 'package:task_management/services/database.dart';


class TaskContent extends StatefulWidget {
  final Task task;
  final userId;

  const TaskContent({
    Key? key,
    required this.task, this.userId,
  }) : super(key: key);

  @override
  _TaskContentState createState() => _TaskContentState();
}

class _TaskContentState extends State<TaskContent> {
  FireStoreDatabase fireStoreDatabase = FireStoreDatabase();

  String? photoUrl;
  String? userName;

  Future<DocumentSnapshot> _currentUserInfo() async {
    DocumentSnapshot documentSnapshot = await fireStoreDatabase.singleUserInfo(widget.userId);
    setState(() {
      photoUrl = documentSnapshot['profileUrl'];
      userName = documentSnapshot['userName'];
    });
    return documentSnapshot;
  }



  @override
  void initState() {
    super.initState();
    _currentUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.only(top: 5, bottom: 5),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Container(
                      padding: EdgeInsets.only(top: 5),
                      child: Text("Priority",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black87)))),
              SizedBox(
                width: 50,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.yellow.shade100,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey.shade200)),
                        child: Text(
                          widget.task.status.toString(),
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.orangeAccent.shade400),
                        )),
                  ),
                ),
              ),
            ],
          ),
          buildLine(),
          Row(
            children: [
              Expanded(
                  child: Container(
                    child: Text("Assigned To",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black87)),
                  )),
              SizedBox(
                width: 50,
              ),


              Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Container(
                          child: Text(userName.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Colors.black87)),

                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ClipOval(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white, width: 2)),
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[600],
                              radius: 20,
                              backgroundImage: photoUrl!.isNotEmpty? NetworkImage(photoUrl!) : AssetImage("assets/images/avatar.png") as ImageProvider,
                            ),

                          ),
                        ),
                      ],
                    ),
                  )),



            ],
          ),
          buildLine(),
          Row(
            children: [
              Expanded(
                  child: Container(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: Text("Creation Time",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black87)))),
              SizedBox(
                width: 50,
              ),
              Expanded(
                  child: Container(

                    child: widget.task.date != null ? Text(
                      widget.task.date!.toDate().day.toString()
                          + "-" +
                          widget.task.date!.toDate().month.toString()
                          + "-" +
                          widget.task.date!.toDate().year.toString(),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent),
                    ) : Text("Loading Date"),

                  ))
            ],
          ),
          buildLine(),
          Row(
            children: [
              Expanded(
                  child: Container(
                      padding: EdgeInsets.only(top: 5, bottom: 10),
                      child: Text("Task Type",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black87)))),
              SizedBox(
                width: 50,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey.shade200)),
                        child: Text(
                          widget.task.category.toString(),
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container buildLine() {
    return Container(
      width: double.infinity,
      child: Divider(
        thickness: 1,
        color: Colors.grey,
      ),
    );
  }
}