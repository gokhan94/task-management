import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  final String title;
  final Icon icon;
  final bool isActive;
  final GestureTapCallback press;

  const NavItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.press,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: EdgeInsets.all(5),
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [IconButton(onPressed: () {}, icon: icon), Text(title)],
        ),
      ),
    );
  }
}
