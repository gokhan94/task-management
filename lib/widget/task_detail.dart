import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_management/auth/auth_service.dart';
import 'package:task_management/model/task.dart';
import 'package:task_management/screen/profile/profile_screen.dart';
import 'package:task_management/services/database.dart';
import 'package:provider/provider.dart';
import 'package:task_management/widget/task_content.dart';
import 'package:intl/intl.dart';

class TaskDetail extends StatefulWidget {
  final id;
  final userId;

  const TaskDetail({Key? key, @required this.id, this.userId}) : super(key: key);

  @override
  _TaskDetailState createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  FireStoreDatabase fireStoreDatabase = FireStoreDatabase();

  Task task = Task();
  int? attendesLength;


  _taskData() async {
    Task taskModel = await fireStoreDatabase.getTask(widget.id);
    setState(() {
      task = taskModel;
      attendesLength = taskModel.attendes!.length;
    });
  }


  @override
  void initState() {
    super.initState();
    _taskData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(task.title.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.grey.shade800)),
                  Spacer(),
                  task.userId == context.read<AuthenticationService>().getCurrentUID
                      ? IconButton(
                          onPressed: () async {
                            bool? isCompleted;

                            setState(() {
                              isCompleted = task.completed == true ? false : true;
                            });
                            await fireStoreDatabase.taskCompleted(widget.id, isCompleted);
                          },
                          icon: Icon(
                            Icons.check_box_outlined,
                            size: 25,
                            color: Colors.green.shade800,
                          ))
                      : Icon(
                          Icons.verified,
                          color: Colors.green,
                        ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(task.description.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      height: 1.3,
                      fontSize: 20,
                      color: Colors.grey.shade700)),
              SizedBox(
                height: 10,
              ),

              TaskContent(task: task, userId: widget.userId),

              SizedBox(
                height: 20,
              ),
              buildTaskText(),
              SizedBox(
                height: 10,
              ),
              RelatedTasks(task: task)
            ],
          ),
        ),
      ),
    );
  }

  Text buildTaskText() {
    return Text("Task Attendees",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.grey.shade900));
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.grey.shade200,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios_rounded),
        color: Colors.black54,
      ),
    );
  }
}




class RelatedTasks extends StatefulWidget {
  final Task task;

  const RelatedTasks({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  _RelatedTasksState createState() => _RelatedTasksState();
}

class _RelatedTasksState extends State<RelatedTasks> {
  FireStoreDatabase fireStoreDatabase = FireStoreDatabase();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200, //MediaQuery.of(context).size.height,
        child: FutureBuilder<QuerySnapshot>(
          future: fireStoreDatabase.getUsers(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  QueryDocumentSnapshot users = snapshot.data!.docs[index];

                  Timestamp now = users['date'];
                  DateTime dateNow = now.toDate();

                    return widget.task.attendes!.any((user) => user['uid'] == users['userId']) ?
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(userId: users.id)),);
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                //width: 60,
                                //height: 60,
                              decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2)),
                                 child: CircleAvatar(
                              backgroundColor: Colors.grey[600],
                              radius: 30,
                              backgroundImage: users['profileUrl'].isNotEmpty? NetworkImage(users['profileUrl']) : AssetImage("assets/images/avatar.png") as ImageProvider,),),
                            Column(
                              children: [
                                Text(users['userName'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.grey.shade900)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("Attendees",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                        color: Colors.grey.shade600)),

                              ],
                            ),
                            Column(
                              children: [
                                Text(DateFormat('MMMd').format(dateNow),
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18,
                                        color: Colors.deepPurpleAccent.shade400)),
                                SizedBox(height: 5,),

                                users['isAdmin'] == true ? Text("Admin" ,style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    color: Colors.green.shade700)) : Text("User", style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    color: Colors.blueAccent)),

                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                        : Text("");
                });
          },
        ));
  }
}
