import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_management/auth/auth_service.dart';
import 'package:task_management/services/database.dart';
import 'package:provider/provider.dart';
import 'package:task_management/widget/task_detail.dart';

class Tasks extends StatefulWidget {
  const Tasks({
    Key? key,
  }) : super(key: key);

  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {

  FireStoreDatabase fireStoreDatabase = FireStoreDatabase();
  final firestoreInstance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(5.0),
        child: SizedBox(
          height: 150,
          child: StreamBuilder<QuerySnapshot>(
              stream: fireStoreDatabase.getTasks(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {

                        // all tasks
                        QueryDocumentSnapshot tasksData = snapshot.data!.docs[index];

                        var list;
                        list = tasksData['attendes'].length - 1;

                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => TaskDetail(id: tasksData.id, userId: tasksData['userId'])),);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                height: 125,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(tasksData['title'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.black87)),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [

                                          Text(tasksData["status"],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Colors
                                                      .yellowAccent.shade700)),

                                          Text(list.toString() + " + going",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Colors.blueAccent)),

                                        tasksData['completed'] == false ? IconButton(
                                              onPressed: () async {
                                                String? uid = context.read<AuthenticationService>().getCurrentUID;
                                                String? email = context.read<AuthenticationService>().getEmail;

                                                await FirebaseFirestore.instance.collection('tasks').doc(tasksData.id).update({
                                                  "attendes" : FieldValue.arrayUnion([
                                                     {"uid": uid }
                                                  ])
                                                });
                                              },
                                              icon: Icon(
                                                Icons.person_add_alt,
                                                color: Colors.green.shade800,
                                                size: 25,
                                              )) : Icon(Icons.verified, color: Colors.green,),

                                          Icon(Icons.arrow_forward_ios_outlined, size: 18, color: Colors.green,),

                                        ],
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        );
                      });
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ));
  }

  ClipOval buildClipOval() {
    return ClipOval(
      child: Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.white, width: 2)),
        child: Image.asset(
          "assets/images/avatar.png",
          height: 40,
          width: 40,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
