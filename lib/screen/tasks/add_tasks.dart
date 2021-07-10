import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormState>();

  static final List<String> items = <String>[
    'Apple',
    'Banana'
  ];

  var  dropdownSelectedItem;

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
                                hint:  Text("Please select category", style: TextStyle(color: Colors.grey.shade600, letterSpacing: 1),),
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
                  ),
                ),


                Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: TextButton(onPressed: (){},
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
      leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.grey,),),
    );
  }
}
