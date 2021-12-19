import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_management/auth/auth_service.dart';
import 'package:task_management/model/category.dart';
import 'package:task_management/services/database.dart';
import 'package:task_management/widget/todo.dart';
import 'package:provider/provider.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({
    Key? key,
  }) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();

}

class _CategoryListState extends State<CategoryList> {

  FireStoreDatabase fireStoreDatabase = FireStoreDatabase();

  int selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    String? uid = context.read<AuthenticationService>().getCurrentUID;
    return SizedBox(
      height: 60,
      child: StreamBuilder<QuerySnapshot>(
        stream: fireStoreDatabase.getCat(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

          if(snapshot.hasData){
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {

                  QueryDocumentSnapshot catData = snapshot.data!.docs[index];

                  var categoryUserId = catData['users'].map((e) => e['uid']);

                  return categoryUserId.contains(uid) ? Padding(
                    padding: EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Todo(category: catData['name'], userId: uid)),);
                        setState(() {
                          selectedCategory = index;
                        });
                      },
                      child: Container(
                        width: 120,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueGrey.shade700, width: 3),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              catData['name'].toString(),
                              style: TextStyle(
                                  color: Colors.blueGrey.shade700,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            )),
                      ),
                    ),
                  ) : Text("");


                });
          }else{
            return CircularProgressIndicator();
          }

        }
      )
    );
  }
}