import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_management/services/database.dart';

class AllTodos extends StatefulWidget {

  final String? userId;

  const AllTodos({Key? key, required this.userId}) : super(key: key);
  @override
  _AllTodosState createState() => _AllTodosState();
}

class _AllTodosState extends State<AllTodos> {

  List<DocumentSnapshot> _tasksPagination = [];
  bool _loading = false;
  bool _gettingMoreTasks = false;
  bool _moreAvailable = true;
  int _limit = 3;
  DocumentSnapshot? _documentSnapshot;
  ScrollController? _scrollController = ScrollController();
  FireStoreDatabase fireStoreDatabase = FireStoreDatabase();

  pagination() async {
    Query query =  FirebaseFirestore.instance.collection('tasks').orderBy('title').limit(_limit);

    setState(() {
      _loading = true;
    });

    QuerySnapshot  snapshot = await query.get();

    _tasksPagination = snapshot.docs;

    _documentSnapshot = snapshot.docs[snapshot.docs.length - 1];

    setState(() {
      _loading = false;
    });

  }

  _getMoreTask() async {

    if(_moreAvailable == false){
      return;
    }

    if(_gettingMoreTasks == true){
      return;
    }

    _gettingMoreTasks = true;

    Query nextQuery =  FirebaseFirestore.instance.collection('tasks').orderBy('title').startAfter([_documentSnapshot!['title']]).limit(_limit);

    QuerySnapshot  querySnapshot = await nextQuery.get(); //  [example4, example5, example6]

    if (querySnapshot.docs.length < _limit) {
      _moreAvailable = false;
    }

    _documentSnapshot = querySnapshot.docs[querySnapshot.docs.length - 1];  // [example6]

    _tasksPagination.addAll(querySnapshot.docs); //  [example1, example2,... example6]

    setState(() {
    });
    _gettingMoreTasks = false;
  }


  String? userName;

  List<QueryDocumentSnapshot> users = [];

  Future<QuerySnapshot> currentUserInfo() async {
    QuerySnapshot querySnapshot = await fireStoreDatabase.getUsers();
    setState(() {
      users = querySnapshot.docs.map((e) => e).toList();
    });
    return querySnapshot;
  }

  @override
  void initState() {
    super.initState();
    pagination();
    currentUserInfo();

    _scrollController!.addListener(() {
      double maxScroll = _scrollController!.position.maxScrollExtent;
      double current = _scrollController!.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.25;

      if(maxScroll - current <= delta){
        _getMoreTask();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Todos",
          style: TextStyle(color: Colors.grey.shade600),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.grey,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            _loading == true ? Container(child: Center(child: Text("loading"),),) :
            Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: SizedBox(
                  height: 600,
                  child: ListView.builder(
                      controller: _scrollController,
                      itemCount: _tasksPagination.length,itemBuilder: (context, index){

                      Timestamp now = _tasksPagination[index]['date'];
                      DateTime dateNow = now.toDate();

                    return Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.all(15),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * .40,
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey.shade300)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Expanded(
                                child: Text(_tasksPagination[index]['title'],
                                    style: TextStyle(
                                        height: 1.4,
                                        wordSpacing: 2,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.black87)),
                              ),
                              Text(DateFormat('MMMd').format(dateNow),
                                  style: TextStyle(
                                      height: 1.4,
                                      wordSpacing: 2,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16,
                                      color: Colors.deepOrange.shade600)),
                            ],),
                          SizedBox(height: 10,),
                          Expanded(
                            child: Text(
                                _tasksPagination[index]['description'].toString(),
                                style: TextStyle(
                                    height: 1.4,
                                    wordSpacing:
                                    2,
                                    fontWeight:
                                    FontWeight
                                        .bold,
                                    fontSize: 18,
                                    color: Colors.grey.shade700)),
                          ),
                          SizedBox(height: 20,),
                          Row(children: [
                            Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.yellow.shade100,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.grey.shade300)
                                ),
                                child: Text(_tasksPagination[index]['status'], style: TextStyle(fontSize: 20,  fontWeight: FontWeight.bold,color: Colors.orangeAccent.shade400),)
                            ),
                            SizedBox(width: 20,),
                            Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.grey.shade300)
                                ),
                                child: Text(_tasksPagination[index]['category'], style: TextStyle(fontSize: 20,  fontWeight: FontWeight.bold,color: Colors.blue),)
                            ),
                          ],),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              _tasksPagination[index]['completed'] == true ?
                              Icon(Icons.verified_outlined, color: Colors.green,) : Icon(Icons.do_not_disturb, color: Colors.redAccent,),

                              Spacer(),

                                  for ( var user in users ) if(user['userId'] == _tasksPagination[index]['userId'])
                                    Row(
                                      children: [
                                        Text(user['userName'],  style: TextStyle(fontSize: 18,  fontWeight: FontWeight.bold,color: Colors.black54)),
                                        SizedBox(width: 10,),
                                        ClipOval(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.white, width: 2)),
                                            child: CircleAvatar(
                                              backgroundColor: Colors.grey[600],
                                              radius: 20,
                                              backgroundImage: user['profileUrl'].isNotEmpty ? NetworkImage(user['profileUrl']) : AssetImage("assets/images/avatar.png") as ImageProvider,
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
}
