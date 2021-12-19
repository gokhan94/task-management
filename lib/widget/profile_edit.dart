import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:task_management/auth/auth_service.dart';
import 'package:task_management/services/database.dart';
import 'package:task_management/services/storage.dart';

class ProfileEdit extends StatefulWidget {
  final data;

  const ProfileEdit({Key? key, this.data}) : super(key: key);
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {

  File? _photoFile;
  FireStoreDatabase fireStoreDatabase = FireStoreDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.white70,
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.close, color: Colors.black,), onPressed: () => Navigator.pop(context)),
        title: Text(
          "Profile Picture Edit",
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          IconButton(icon: Icon(Icons.check, color: Colors.black,), onPressed: _save),
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20.0),
        child:  InkWell(
            onTap: _pictureChange,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    //NetworkImage(widget.data['profileUrl'])
                    //AssetImage("assets/images/avatar.png")
                    backgroundImage: _photoFile == null ? NetworkImage(widget.data['profileUrl']) : FileImage(_photoFile!) as ImageProvider,
                    radius: 55.0,
                  ),
                ),
              ],
            ),
          ),

      ),
    );
  }

   _save() async {

     String photoUrl;

     if(_photoFile == null){
       photoUrl = widget.data['profileUrl'];
     } else {
       photoUrl =  await StorageServices().loadPicture(_photoFile!);
     }

     final userId = context.read<AuthenticationService>().getCurrentUID;

     await fireStoreDatabase.updatePhoto(userId, photoUrl);

     Navigator.pop(context);

  }

   _pictureChange() async {
     var image = await ImagePicker().pickImage(source: ImageSource.camera, maxWidth: 200, maxHeight: 200, imageQuality: 80);
     setState(() {
       _photoFile = File(image!.path);
     });
  }
}
