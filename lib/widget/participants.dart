import 'package:flutter/material.dart';
import 'package:task_management/screen/profile/profile_screen.dart';

class Participants extends StatefulWidget {
  const Participants({
    Key? key,
    required this.size, required this.eventAttendeeList,
  }) : super(key: key);

  final Size size;
  final eventAttendeeList;

  @override
  _ParticipantsState createState() => _ParticipantsState();
}

class _ParticipantsState extends State<Participants> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 30),
              child: Text("Going",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black87)),
            )),

        Expanded(
          child: Container(
            width: widget.size.width * .30,
            height: 50,
            child: Stack(
              children: [
                 ListView.builder(
                     shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                        itemCount: widget.eventAttendeeList.length,
                        itemBuilder: (context, index){
                      return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>
                              ProfileScreen(userId: widget.eventAttendeeList[index]['userId'],),
                          ),);
                        },
                        child: ClipOval(
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white, width: 2)),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey[600],
                                    radius: 20,
                                    backgroundImage: widget.eventAttendeeList[index]['profileUrl'].isNotEmpty  ? NetworkImage(widget.eventAttendeeList[index]['profileUrl']) : AssetImage("assets/images/avatar.png") as ImageProvider,),
                                ),
                              ),
                      );

                    }),

              ],
            ),
          ),
        ),

        SizedBox(width: 10,),

        Expanded(
          child: Text("+" + widget.eventAttendeeList.length.toString() + " going",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.blueAccent.shade400)),
        ),

      ],
    );
  }
}