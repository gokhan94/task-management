import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/auth/auth_service.dart';
import 'package:task_management/services/database.dart';

class CategoryAdd extends StatefulWidget {
  @override
  _CategoryAddState createState() => _CategoryAddState();
}

class _CategoryAddState extends State<CategoryAdd> {
  final _formKey = GlobalKey<FormState>();
  final firestoreInstance = FirebaseFirestore.instance;
  FireStoreDatabase fireStoreDatabase = FireStoreDatabase();

  String? name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildContainer(),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      hintText: "Category Name",
                      hintStyle: TextStyle(color: Colors.grey.shade600, letterSpacing: 1),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onSaved: (value) => name = value,
                  ),
                ),

                Center(
                  child: Padding(
                    padding:  EdgeInsets.all(20.0),
                    child: TextButton(
                        onPressed: () async {

                          final form = _formKey.currentState;

                          final userId  = context.read<AuthenticationService>().getCurrentUID;

                          if(form!.validate()){
                            form.save();

                            await fireStoreDatabase.saveCategory(userId, this.name);
                            Navigator.pop(context);

                          }


                        },
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.grey.shade300,
                            padding: EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))
                        ),
                        child: Text("Create Category", style: TextStyle(color: Colors.blueGrey, fontSize: 20),)),
                  ),
                )


              ],
            ),
          ),
        ));
  }

  Container buildContainer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Text(
        "Category Page !",
        style: TextStyle(
            color: Colors.black87, fontSize: 30, fontWeight: FontWeight.w600),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.grey,),),
    );
  }
}
