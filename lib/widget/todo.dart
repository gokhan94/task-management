import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_management/auth/auth_service.dart';
import 'package:task_management/model/task.dart';
import 'package:task_management/screen/home/home_screen.dart';
import 'package:task_management/services/database.dart';
import 'package:provider/provider.dart';

class Todo extends StatefulWidget {
  final String? category;
  final String? userId;

  const Todo({Key? key, this.category, required this.userId}) : super(key: key);

  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  FireStoreDatabase fireStoreDatabase = FireStoreDatabase();

  List<Task> _task = [];
  bool _IsTodos = false;
  int _selectedIndex = 0;
  String? photoUrl;
  String? userName;

  getTask() async {
    List<Task> tasks = await fireStoreDatabase.categoryTask(widget.category);
    setState(() {
      _task = tasks;
      if (_task.length > 0) {
        _IsTodos = true;
      }
    });
  }


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
    getTask();
    _currentUserInfo();
  }

  List<ElevatedButton> indexButton = [
    ElevatedButton(
      style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.all(10),
          ),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: MaterialStateProperty.all(Colors.red.shade600),
          elevation: MaterialStateProperty.all(10),
          shadowColor: MaterialStateProperty.all(Colors.redAccent),
          ),
      onPressed: () {},
      child: Text('COMPLETED',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
    ),
    ElevatedButton(
      style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.all(10),
          ),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: MaterialStateProperty.all(Colors.red.shade600),
          elevation: MaterialStateProperty.all(10),
          shadowColor: MaterialStateProperty.all(Colors.redAccent),
          ),
      onPressed: () {},
      child: Text('NO COMPLETED',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
    ),
  ];


  @override
  Widget build(BuildContext context) {

    final userId  = context.read<AuthenticationService>().getCurrentUID;

    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: indexButton.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                            child: Row(
                              children: [
                                index == 0
                                    ? ElevatedButton(
                                        style: _selectedIndex == 0 ?
                                        indexButton[0].style :
                                        indexButton[0].style!.copyWith(
                                          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10),),
                                          backgroundColor: MaterialStateProperty.all(Colors.grey.shade500),
                                          elevation: MaterialStateProperty.all(10),
                                          shadowColor: MaterialStateProperty.all(Colors.grey),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _selectedIndex = index;
                                          });
                                        },
                                        child: indexButton[0].child,
                                      )
                                    : ElevatedButton(
                                        style: _selectedIndex == 1 ? indexButton[1].style :
                                        ButtonStyle(
                                          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10),),
                                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                          backgroundColor: MaterialStateProperty.all(Colors.grey.shade500),
                                          elevation: MaterialStateProperty.all(10),
                                          shadowColor: MaterialStateProperty.all(Colors.grey),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _selectedIndex = index;
                                          });
                                        },
                                        child: indexButton[1].child,
                                      ),
                              ],
                            )),

                    );
                  }),
            ),

            _selectedIndex == 0 ?
            SizedBox(
                    height: 600,
                    child: Padding(
                      padding:  EdgeInsets.all(10.0),
                      child: ListView.builder(
                          itemCount: _task.length,
                          itemBuilder: (context, index) {
                            return _task[index].completed == true && _task[index].userId == userId
                                ? Column(
                                    children: [
                                      _IsTodos == false
                                          ? Container(
                                              child: Center(
                                                child: Text(
                                                  "There are no tasks in this category",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              ),
                                            )
                                          : Padding(
                                              padding: EdgeInsets.only(left: 10, right: 10),
                                              child: Container(
                                                padding: EdgeInsets.all(15),
                                                width: double.infinity,
                                                height: MediaQuery.of(context).size.height * .50,
                                                decoration: BoxDecoration(
                                                    color: Colors.white70,
                                                    borderRadius:
                                                        BorderRadius.circular(20),
                                                    border: Border.all(
                                                        color: Colors.grey.shade300)),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                              _task[index].title.toString(),
                                                              style: TextStyle(
                                                                  height: 1.4,
                                                                  wordSpacing:
                                                                      2,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .black87)),
                                                        ),
                                                        IconButton(
                                                            onPressed: (){
                                                              showDialog(
                                                                  barrierDismissible: true,
                                                                  barrierColor: Colors.grey.shade200,
                                                                  context: context,
                                                                  builder: (ctxt) =>  AlertDialog(
                                                                    title: Text("Delete ${_task[index].title} Task",  style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
                                                                    content: Text("Task will be deleted.You will be redirected to the homepage.Do you confirm ?",
                                                                      style: TextStyle(color: Colors.red.shade600, fontWeight: FontWeight.w500,fontSize: 20),),
                                                                    actions: [
                                                                      TextButton(
                                                                        child: Text("Exit", style: TextStyle(color: Colors.grey.shade600, fontSize: 20, fontWeight: FontWeight.bold)),
                                                                        onPressed: () {
                                                                          Navigator.pop(context);
                                                                        },
                                                                      ),
                                                                      TextButton(
                                                                        child: Text("Delete", style: TextStyle(color: Colors.red.shade600, fontSize: 20, fontWeight: FontWeight.bold)),
                                                                        onPressed: () {
                                                                          fireStoreDatabase.deleteTask(_task[index].id);
                                                                          Navigator.push(context, MaterialPageRoute(builder: (context) => Home()),);
                                                                        },
                                                                      ),
                                                                    ],
                                                                  )
                                                              );


                                                            }, icon: Icon(Icons.delete, color: Colors.redAccent, size: 25,)),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),

                                                    Expanded(
                                                      child: Text(
                                                          _task[index].description.toString(),
                                                          style: TextStyle(
                                                              height: 1.4,
                                                              wordSpacing:
                                                              2,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              fontSize: 20,
                                                              color: Colors
                                                                  .black87)),
                                                    ),

                                                    SizedBox(
                                                      height: 20,
                                                    ),

                                                    Row(
                                                      children: [
                                                        Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .yellow
                                                                    .shade100,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade300)),
                                                            child: Text(
                                                              _task[index]
                                                                  .status
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .orangeAccent
                                                                      .shade400),
                                                            )),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .blue
                                                                    .shade50,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade300)),
                                                            child: Text(
                                                              _task[index]
                                                                  .category
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .blue),
                                                            )),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        _task[index].completed == true ? Icon(Icons.lock, color: Colors.red,) : Icon(Icons.lock_open_rounded, color: Colors.green,),
                                                        Spacer(),
                                                        Row(
                                                          children: [
                                                            Text(userName.toString(),
                                                                style: TextStyle(
                                                                    fontSize: 18,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: Colors.black54)),
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
                                                                  backgroundImage: photoUrl!.isNotEmpty ? NetworkImage(photoUrl!) : AssetImage("assets/images/avatar.png") as ImageProvider,
                                                                ),

                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                      SizedBox(height: 20,),
                                    ],
                                  )
                                : Text("");
                          }),
                    ),
                  )
                : SizedBox(
              height: 600,
              child: Padding(
                padding:  EdgeInsets.all(10.0),
                child: ListView.builder(
                    itemCount: _task.length,
                    itemBuilder: (context, index) {
                      return _task[index].completed == false && _task[index].userId == userId
                          ? Column(
                        children: [
                          _IsTodos == false
                              ? Container(
                            child: Center(
                              child: Text(
                                "There are no tasks in this category",
                                style:
                                TextStyle(fontSize: 20),
                              ),
                            ),
                          )
                              : Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              padding: EdgeInsets.all(15),
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * .50,
                              decoration: BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius:
                                  BorderRadius.circular(20),
                                  border: Border.all(
                                      color: Colors.grey.shade300)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                            _task[index]
                                                .title
                                                .toString(),
                                            style: TextStyle(
                                                height: 1.4,
                                                wordSpacing:
                                                2,
                                                fontWeight:
                                                FontWeight
                                                    .bold,
                                                fontSize: 20,
                                                color: Colors
                                                    .black87)),
                                      ),


                                      IconButton(
                                          onPressed: (){
                                            showDialog(
                                              barrierDismissible: true,
                                              barrierColor: Colors.grey.shade200,
                                                context: context,
                                                builder: (ctxt) =>  AlertDialog(
                                                  title: Text("Delete ${_task[index].title} Task",  style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
                                                  content: Text("Task will be deleted.You will be redirected to the homepage.Do you confirm ?",
                                                    style: TextStyle(color: Colors.red.shade900, fontWeight: FontWeight.w500,fontSize: 20),),
                                                  actions: [
                                                    TextButton(
                                                      child: Text("Exit", style: TextStyle(color: Colors.grey.shade600, fontSize: 20, fontWeight: FontWeight.bold)),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: Text("Delete", style: TextStyle(color: Colors.red.shade600, fontSize: 20, fontWeight: FontWeight.bold)),
                                                      onPressed: () {
                                                        fireStoreDatabase.deleteTask(_task[index].id);
                                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()),);
                                                      },
                                                    ),
                                                  ],
                                                )
                                            );


                                      }, icon: Icon(Icons.delete, color: Colors.redAccent, size: 25,)),

                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),


                                  Expanded(
                                    child: Text(
                                          _task[index].description.toString(),
                                          style: TextStyle(
                                              height: 1.4,
                                              wordSpacing:
                                              2,
                                              fontWeight:
                                              FontWeight
                                                  .w500,
                                              fontSize: 20,
                                              color: Colors
                                                  .black87)),
                                  ),


                                  SizedBox(
                                    height: 20,
                                  ),

                                  Row(
                                    children: [
                                      Container(
                                          padding:
                                          EdgeInsets.all(
                                              5),
                                          decoration: BoxDecoration(
                                              color: Colors
                                                  .yellow
                                                  .shade100,
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  5),
                                              border: Border.all(
                                                  color: Colors
                                                      .grey
                                                      .shade300)),
                                          child: Text(
                                            _task[index]
                                                .status
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight:
                                                FontWeight
                                                    .bold,
                                                color: Colors
                                                    .orangeAccent
                                                    .shade400),
                                          )),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                          padding:
                                          EdgeInsets.all(
                                              5),
                                          decoration: BoxDecoration(
                                              color: Colors
                                                  .blue
                                                  .shade50,
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  5),
                                              border: Border.all(
                                                  color: Colors
                                                      .grey
                                                      .shade300)),
                                          child: Text(
                                            _task[index]
                                                .category
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight:
                                                FontWeight
                                                    .bold,
                                                color: Colors
                                                    .blue),
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      _task[index].completed == true ? Icon(Icons.lock, color: Colors.red,) : Icon(Icons.lock_open_rounded, color: Colors.green,),
                                      Spacer(),
                                      Row(
                                        children: [
                                          Text(userName.toString(),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54)),
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
                                                backgroundImage: photoUrl!.isNotEmpty ? NetworkImage(photoUrl!) : AssetImage("assets/images/avatar.png") as ImageProvider,
                                              ),

                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                        ],
                      )
                          : Text("");
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.grey.shade600,
          size: 25,
        ),
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


