import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_management/auth/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:task_management/model/event.dart';
import 'package:task_management/services/database.dart';
import 'package:task_management/widget/event_details.dart';

class EventList extends StatefulWidget {
  const EventList({
    Key? key,
  }) : super(key: key);

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  FireStoreDatabase fireStoreDatabase = FireStoreDatabase();

  String? photoUrl;
  String? userName;
  String? userId;

  Future<DocumentSnapshot> currentUserInfo() async {

    String? user = context.read<AuthenticationService>().getCurrentUID;
    DocumentSnapshot documentSnapshot = await fireStoreDatabase.singleUserInfo(user);

  if(mounted){
    setState(() {
      photoUrl = documentSnapshot['profileUrl'];
      userName = documentSnapshot['userName'];
      userId   = documentSnapshot['userId'];
    });
  }

    return documentSnapshot;
  }


 @override
  void initState() {
    super.initState();
    currentUserInfo();
  }



  @override
  Widget build(BuildContext context) {
    String? uid = context.read<AuthenticationService>().getCurrentUID;

    return Container(
      height: MediaQuery.of(context).size.height * .30,
      child: StreamBuilder<QuerySnapshot>(
          stream: fireStoreDatabase.getEvents(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    // all events
                    QueryDocumentSnapshot eventData = snapshot.data!.docs[index];

                    final eventModel = Event(
                      id: eventData['id'],
                      title: eventData['title'],
                      description: eventData['description'],
                      userId: eventData['userId'],
                      completed: eventData['completed'],
                      date: eventData['date'],
                      time: eventData['time'],
                      address: eventData['address']
                    );

                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EventDetails(event: eventModel, /*id: eventData.id,*/ userId: uid)),);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 1.5, color: Colors.blueGrey.shade100),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: MediaQuery.of(context).size.width * .60,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(eventData['title'],
                                    style: TextStyle(
                                        color: Colors.blueGrey.shade700,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20)),

                              SizedBox(
                                height: 10,
                              ),


                               Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Text(eventData['time'],
                                        style: TextStyle(
                                            color: Colors.indigoAccent,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                   SizedBox(width: 10,),


                                   Icon(Icons.event, color: Colors.grey.shade700),



                                   /*Text(eventData['date'],
                                       style: TextStyle(
                                           color: Colors.indigoAccent.shade100,
                                           fontWeight: FontWeight.bold,
                                           fontSize: 18)),*/


                                 ],
                               ),


                              SizedBox(
                                height: 10,
                              ),

                              eventData['userId'] == userId ?

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                   ClipOval(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white,
                                                width: 2)),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.grey[600],
                                          radius: 20,
                                          backgroundImage: photoUrl!.isNotEmpty ?  NetworkImage(photoUrl!) : AssetImage("assets/images/avatar.png") as ImageProvider,),
                                      ),
                                    ),



                                   Text(userName.toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueGrey.shade600),)



                                ],
                              ) : Text("No User"),

                              /*Container(
                                width: double.infinity,
                                height: 40,
                                child: Stack(
                                  children: [
                                    ...List.generate(4, (index) {
                                      return Positioned(
                                          left: (30 * index).toDouble(),
                                          child: ClipOval(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 2)),
                                              child: Image.asset(
                                                "assets/images/coffee_time.png",
                                                height: 40,
                                                width: 40,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ));
                                    }),
                                  ],
                                ),
                              ),*/



                            ],
                          ),
                        ),
                        // height: 200,
                      ),
                    );
                  });
            }else{
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
