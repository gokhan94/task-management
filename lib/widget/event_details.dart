import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_management/model/event.dart';
import 'package:task_management/services/database.dart';
import 'package:task_management/widget/date.dart';
import 'package:task_management/widget/event_content.dart';
import 'package:task_management/widget/participants.dart';

class EventDetails extends StatefulWidget {
  final Event event;
  final userId;

  const EventDetails(
      {Key? key, required this.event,  required this.userId})
      : super(key: key);
  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  FireStoreDatabase fireStoreDatabase = FireStoreDatabase();

  String? photoUrl;
  String? userName;

  Future<DocumentSnapshot> currentUserInfo() async {
    DocumentSnapshot documentSnapshot = await fireStoreDatabase.singleUserInfo(widget.userId);
    setState(() {
      photoUrl = documentSnapshot['profileUrl'];
      userName = documentSnapshot['userName'];
    });
    return documentSnapshot;
  }

  List<QueryDocumentSnapshot> _eventAttendeeList = [];
  getAttendees() async {
    List<QueryDocumentSnapshot> event = await fireStoreDatabase.getAttendeesEvent(widget.event.id);
    setState(() {
      _eventAttendeeList = event;
    });
  }

  @override
  void initState() {
    super.initState();
    currentUserInfo();
    getAttendees();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                height: size.height,
                child: Stack(
                  children: [
                    EventBackdrop(size: size),
                    Container(
                      margin: EdgeInsets.only(top: size.height * 0.15),
                      width: double.infinity,
                      height: size.height * 0.8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          color: Colors.grey.shade50),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(widget.event.title.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                        color: Colors.blueGrey.shade900)),
                                Spacer(),
                                _eventAttendeeList.any((user) => user['userId'] == widget.userId) ?
                                    Text("Already registered",
                                        style: TextStyle(fontSize: 18, color: Colors.grey),
                                      )
                                    : IconButton(
                                        onPressed: () async {
                                          await fireStoreDatabase.saveAttendeesEvent(widget.event.id, widget.userId, userName, photoUrl);
                                        },
                                        icon: Icon(
                                          Icons.person_add_alt,
                                          size: 30,
                                          color: Colors.green.shade400,
                                        )),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border:
                                      Border.all(color: Colors.grey, width: 1)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Date(event: widget.event),
                                  buildLine(),
                                  Participants(size: size, eventAttendeeList: _eventAttendeeList),
                                ],
                              ),
                            ),

                             SizedBox(height: 20,),

                             Row(
                                children: [
                                  Icon(Icons.location_on, color: Colors.grey, size: 25,),
                                  Text(widget.event.address.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                          color: Colors.grey.shade800)),
                                ],
                              ),



                            eventAboutTitle(),
                            EventContent(event: widget.event),
                          ],
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Padding eventAboutTitle() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Container(
        child: Text("About Event",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black87)),
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

class EventBackdrop extends StatelessWidget {
  const EventBackdrop({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: size.height * 0.2,
            width: size.width,
            decoration:  BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                color: Colors.grey.shade200),
        child: Row(
          children: [
            IconButton(onPressed: (){ Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.grey,)),
            SizedBox(width: 10,),
            Text("Event Info Page", style: TextStyle(color: Colors.blueGrey, fontSize: 25, fontWeight: FontWeight.w600),),
          ],
        ),
        )
      ],
    );
  }
}
