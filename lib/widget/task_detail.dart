import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskDetail extends StatefulWidget {
  @override
  _TaskDetailState createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
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
                  Text("Web Design",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.grey.shade800)),
                  SizedBox(width: 20,),
                  Icon(Icons.verified_outlined, color: Colors.green.shade700,)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                  "Content is upload and shared. Uploaded when the user specifies when the music will be avaliable to the general public.",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      height: 1.3,
                      fontSize: 20,
                      color: Colors.grey.shade700)),
              SizedBox(
                height: 10,
              ),
              TaskContent(),
              SizedBox(
                height: 20,
              ),
              buildTaskText(),
              SizedBox(
                height: 10,
              ),
              RelatedTasks()
            ],
          ),
        ),
      ),
    );
  }

  Text buildTaskText() {
    return Text("Related Tasks",
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
        onPressed: () {},
        icon: Icon(Icons.arrow_back_ios_rounded),
        color: Colors.black54,
      ),
    );
  }
}

class TaskContent extends StatelessWidget {
  const TaskContent({
    Key? key,
  }) : super(key: key);

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
                          "HIGHT",
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
                      child: Text("Devon Lane",
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
                            border: Border.all(color: Colors.white, width: 1)),
                        child: Image.asset(
                          "assets/images/coffee_time.png",
                          height: 35,
                          width: 35,
                          fit: BoxFit.cover,
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
                      child: Text("Due Date",
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
                      child: Text(
                "Due 17 Oct",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent),
              )))
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
                          "DEVELOPMENT",
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

class RelatedTasks extends StatelessWidget {
  const RelatedTasks({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
          itemCount: 30,
          itemBuilder: (context, index) {
            return Container(
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
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage('assets/images/coffee_time.png'),
                          fit: BoxFit.cover,
                        ),
                      )),
                  Column(
                    children: [
                      Text("Lexsas Aplication",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.grey.shade900)),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Jacob Jones",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              color: Colors.grey.shade600)),
                    ],
                  ),
                  Column(
                    children: [
                      Text("07/04/2021",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              color: Colors.grey.shade600)),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Completed",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              color: Colors.cyanAccent.shade700)),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
