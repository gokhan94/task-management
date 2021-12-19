import 'package:flutter/material.dart';
import 'package:task_management/auth/auth_service.dart';
import 'package:task_management/screen/intro/intro.dart';
import 'package:task_management/screen/profile/profile_picture.dart';
import 'package:task_management/services/database.dart';
import 'package:task_management/widget/profile_edit.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final userId;

  const ProfileScreen({Key? key, required this.userId}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  FireStoreDatabase fireStoreDatabase = FireStoreDatabase();

  int? userTaskLength;
  int? userEventLength;

  userTaskCount() async {
    int taskLength = await fireStoreDatabase.userTaskLength(widget.userId);
    setState(() {
      userTaskLength = taskLength;
    });
  }

  userEventCount() async {
    int eventLength = await fireStoreDatabase.userEventLength(widget.userId);
    setState(() {
      userEventLength = eventLength;
    });
  }


  @override
  void initState() {
    super.initState();
    userTaskCount();
    userEventCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: FutureBuilder<Object>(
          future: fireStoreDatabase.singleUserInfo(widget.userId),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.hasData){
              return Column(
                children: [
                  ProfilePicture(data: snapshot.data),
                  SizedBox(
                    height: 20,
                  ),
                  ProfileMenu(
                    title: "My Account Edit",
                    icon: Icons.person,
                    press: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileEdit(data: snapshot.data)),);
                    },
                  ),
                  ProfileMenu(
                    title: "My Tasks Length : $userTaskLength",
                    icon: Icons.title,
                    press: () {},
                  ),
                  ProfileMenu(
                    title: "My Event Length : $userEventLength",
                    icon: Icons.event,
                    press: () {},
                  ),
                  ProfileMenu(
                    title: "Logout",
                    icon: Icons.logout,
                    press: () async {
                      await context.read<AuthenticationService>().signOut();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Intro()),);

                    },
                  )
                ],
              );
            }else{
              return Center(child: CircularProgressIndicator());
            }
      })
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white70,
      elevation: 0,
      title: Text(
        "Profile",
        style: TextStyle(color: Colors.grey),
      ),
      centerTitle: true,
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.title,
    required this.press,
    required this.icon,
  }) : super(key: key);

  final String title;
  final VoidCallback press;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: Colors.grey.shade200,
              padding: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: press,
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.grey,
                size: 30,
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(color: Colors.black87, fontSize: 16),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 25,
              )
            ],
          )),
    );
  }
}


