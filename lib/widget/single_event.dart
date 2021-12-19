import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_management/auth/auth_service.dart';
import 'package:task_management/model/event.dart';
import 'package:task_management/services/database.dart';
import 'package:task_management/widget/event_details.dart';
import 'package:provider/provider.dart';

class UserEventSingle extends StatefulWidget {
  final userId;

  const UserEventSingle({Key? key, this.userId}) : super(key: key);
  @override
  _UserEventSingleState createState() => _UserEventSingleState();
}

class _UserEventSingleState extends State<UserEventSingle> {
  FireStoreDatabase fireStoreDatabase = FireStoreDatabase();

  List<Event> _userEventList = [];

  getEvents() async {
    List<Event> events = await fireStoreDatabase.singleEventInfo(widget.userId);
    setState(() {
      _userEventList = events;
    });
  }

  @override
  void initState() {
    super.initState();
    getEvents();
  }

  @override
  Widget build(BuildContext context) {
    String? uid = context.read<AuthenticationService>().getCurrentUID;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "User Events",
            style: TextStyle(color: Colors.grey.shade600),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.grey,
            ),
          ),
        ),
        body: ListView.builder(
            itemCount: _userEventList.length,
            itemBuilder: (context, index) {
              final eventModel = Event(
                id: _userEventList[index].id,
                title: _userEventList[index].title,
                description: _userEventList[index].description,
                userId: _userEventList[index].userId,
                completed: _userEventList[index].completed,
                date: _userEventList[index].date,
                time: _userEventList[index].time,
                address: _userEventList[index].address,
              );

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EventDetails(event: eventModel, userId: uid)),
                  );
                },
                child: Container(
                  height: 350,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.title,
                            color: Colors.grey,
                            size: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Title",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(_userEventList[index].title.toString(),
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w700,
                                fontSize: 18)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.grey,
                            size: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Address",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(_userEventList[index].address.toString(),
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                                fontSize: 18)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.description_outlined,
                            color: Colors.grey,
                            size: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Description",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                            _userEventList[index].description.toString(),
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                                fontSize: 18)),
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Go To Event Detail"),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}
