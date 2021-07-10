import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: [
          ProfilePicture(),
          SizedBox(
            height: 20,
          ),
          ProfileMenu(
            title: "My Account",
            icon: Icons.person,
            press: () {
              print("Profile Page");
            },
          ),
          ProfileMenu(
            title: "Notification",
            icon: Icons.notifications_active_outlined,
            press: () {

            },
          ),
          ProfileMenu(
            title: "Settings",
            icon: Icons.settings,
            press: () {

            },
          ),
          ProfileMenu(
            title: "My Tasks",
            icon: Icons.add_task_outlined,
            press: () {

            },
          ),
          ProfileMenu(
            title: "Events",
            icon: Icons.event,
            press: () {

            },
          )
        ],
      ),
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

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey,
          ),
          Positioned(
            right: -10,
            bottom: 0,
            child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey, width: 1)),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.photo_camera),
                  color: Colors.grey,
                )),
          )
        ],
      ),
    );
  }
}
