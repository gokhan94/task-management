import 'package:flutter/material.dart';

class ProfilePicture extends StatefulWidget {

  final data;

  const ProfilePicture({
    Key? key, required this.data,
  }) : super(key: key);

  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {

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
            backgroundColor: Colors.grey[600],
            radius: 60.0,
            backgroundImage: widget.data['profileUrl'].isNotEmpty  ? NetworkImage(widget.data['profileUrl']) : AssetImage("assets/images/avatar.png") as ImageProvider,
          ),

          /* Positioned(
            right: -10,
            bottom: 0,
            child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey, width: 1)),
                child: file == null ? IconButton(
                  onPressed: () => _pictureChange(),
                  icon: Icon(Icons.add_a_photo),
                  color: Colors.grey.shade600,
                ) :
                IconButton(
                  onPressed: () => _saveChange(),
                  icon: Icon(Icons.monochrome_photos_outlined),
                  color: Colors.grey.shade600,
                )
            ),
          ),*/
        ],
      ),
    );
  }
}