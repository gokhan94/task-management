import 'package:flutter/material.dart';

class Todo extends StatefulWidget {
  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
            children: [
              TodoButton(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(itemCount: 5,itemBuilder: (context, index){
                    return Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.all(15),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * .30,
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey.shade300)
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Expanded(
                              child: Text("Localz App Design Final Feedback",
                                  style: TextStyle(
                                     height: 1.4,
                                      wordSpacing: 2,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.black87)),
                            ),
                            Text("Oct 16 Due",
                                style: TextStyle(
                                    height: 1.4,
                                    wordSpacing: 2,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    color: Colors.deepOrange.shade600)),
                          ],),
                          SizedBox(height: 20,),
                          Row(children: [
                            Container(
                              padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.yellow.shade100,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.grey.shade300)
                                ),
                                child: Text("HIGHT", style: TextStyle(fontSize: 20,  fontWeight: FontWeight.bold,color: Colors.orangeAccent.shade400),)
                            ),
                            SizedBox(width: 20,),
                            Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.grey.shade300)
                                ),
                                child: Text("DESIGN", style: TextStyle(fontSize: 20,  fontWeight: FontWeight.bold,color: Colors.blue),)
                            ),
                          ],),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                            Icon(Icons.attach_file),
                            Text("1", style: TextStyle(fontSize: 18,  fontWeight: FontWeight.bold,color: Colors.grey)),
                            Spacer(),
                            Row(
                              children: [
                                Text("Gökhan", style: TextStyle(fontSize: 18,  fontWeight: FontWeight.bold,color: Colors.black54)),
                                SizedBox(width: 10,),
                                ClipOval(
                                  child: Container(
                                    decoration:
                                    BoxDecoration(border: Border.all(color: Colors.white, width: 2)),
                                    child: Image.asset(
                                      "assets/images/coffee_time.png",
                                      height: 40,
                                      width: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],),
                        ],
                      ),
                    );
                  }),
                )
              )
            ],
          ),

      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: Icon(
        Icons.arrow_back,
        color: Colors.grey.shade600,
        size: 25,
      ),
      elevation: 0,
      title: Text(
        "TODOS",
        style: TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
            fontSize: 25),
      ),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.push_pin_outlined,
              color: Colors.grey.shade600,
              size: 25,
            )),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search_rounded,
              color: Colors.grey.shade700,
              size: 25,
            )),
      ],
    );
  }
}

class TodoButton extends StatelessWidget {
  const TodoButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.all(10),
                  ),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all(Colors.red.shade600),
                  elevation: MaterialStateProperty.all(10),
                  shadowColor: MaterialStateProperty.all(Colors.redAccent),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          //side: BorderSide(color: Colors.brown)
                      ))),
              onPressed: () {
              },
              child: Text(
                'TASKS',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
            ),
          ),
          SizedBox(width: 20,),
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.all(10),
                  ),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade600),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  elevation: MaterialStateProperty.all(10),
                  shadowColor: MaterialStateProperty.all(Colors.grey),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.white70)
                      ))),
              onPressed: () {
              },
              child: Text(
                'CHECKLIST',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
