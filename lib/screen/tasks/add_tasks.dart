import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/auth/auth_service.dart';
import 'package:task_management/model/category.dart';
import 'package:task_management/services/database.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormState>();
  final firestoreInstance = FirebaseFirestore.instance;
  FireStoreDatabase fireStoreDatabase = FireStoreDatabase();

  String? title, description;
  static final List<String> items = <String>[
    'HIGHT',
    'LOW',
    'HARD'
  ];

  var dropdownSelectedItem;
  var category;
  bool completed = false;
  DateTime? date = DateTime.now();


  List<Category> _categoryList = [];

  getCategory() async {
    List<Category> category = await fireStoreDatabase.getCategories();
    setState(() {
      _categoryList = category;
    });
  }

  @override
  void initState() {
    super.initState();
    getCategory();
  }


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
                      hintText: "Todo Title",
                      hintStyle: TextStyle(color: Colors.grey.shade600, letterSpacing: 1),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onSaved: (value) => title = value,
                  ),
                ),


                Padding(padding: EdgeInsets.all(20.0),
                  child: FormField(
                    builder: (FormFieldState<String> state){
                      return InputDecorator(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          hintStyle: TextStyle(color: Colors.grey.shade600, letterSpacing: 1),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),),
                        isEmpty: category == '',
                        child:  DropdownButtonHideUnderline(
                             child: Padding(
                               padding: EdgeInsets.only(left: 10, right: 10),
                               child: DropdownButton<String>(
                                 hint:  Text("Please select category", style: TextStyle(color: Colors.grey.shade600, letterSpacing: 1),),
                                 value:  category,
                                 //isDense: true,
                                 items: _categoryList.map<DropdownMenuItem<String>>((category) =>
                                     DropdownMenuItem<String>(
                                       value: category.name,
                                       child:  Text(category.name.toString(), style: TextStyle(fontSize: 18, color: Colors.grey.shade600, letterSpacing: 1,)),
                                     )).toList(),
                                 onChanged: (value){
                                   setState(() {
                                     this.category = value!;
                                   });
                                 },
                               ),
                             ),
                            ),

                      );
                    },
                  ),
                ),


                Padding(padding: EdgeInsets.all(20.0),
                  child: FormField(
                    builder: (FormFieldState<String> state){
                      return InputDecorator(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        hintStyle: TextStyle(color: Colors.grey.shade600, letterSpacing: 1),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),),
                        isEmpty: dropdownSelectedItem == '',
                          child: DropdownButtonHideUnderline(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: DropdownButton<String>(
                                hint:  Text("Please select task level", style: TextStyle(color: Colors.grey.shade600, letterSpacing: 1),),
                                value:  dropdownSelectedItem,
                                //isDense: true,
                                items: items.map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item, style: TextStyle(fontSize: 18, color: Colors.grey.shade600, letterSpacing: 1,)),

                                )).toList(),
                                onChanged: (value){
                                  setState(() {
                                    this.dropdownSelectedItem = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                      );
                    },
                  ),
                  ),



                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: TextFormField(
                    maxLines: null,
                    maxLength: 100,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
                      hintText: "Todo Description",
                      hintStyle: TextStyle(color: Colors.grey.shade600, letterSpacing: 1),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      isDense: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onSaved: (value) => description = value,
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

                           var categoryId = _categoryList.where((element) => element.name == category).first.id;

                            await FirebaseFirestore.instance.collection('categories').doc(categoryId).update({
                              "users" : FieldValue.arrayUnion([
                                {"uid": userId }
                              ])
                            });

                            await fireStoreDatabase.saveTask(userId, this.date, this.title, this.description, this.category, this.dropdownSelectedItem, this.completed);
                            Navigator.pop(context);

                          }


                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.grey.shade300,
                            padding: EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))
                        ),
                        child: Text("Create Todo", style: TextStyle(color: Colors.blueGrey, fontSize: 20),)),
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
                  "Create Todos !",
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
