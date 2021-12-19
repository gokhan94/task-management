import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_management/model/category.dart';
import 'package:task_management/model/event.dart';
import 'package:task_management/model/task.dart';
import 'package:task_management/model/user.dart';

class FireStoreDatabase {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final DateTime date = DateTime.now();

  Future<void> createUser({userId, email, userName, profileUrl="", isAdmin = false}) async {
    await firestore.collection("users").doc(userId).set({
      "userId": userId,
      "userName": userName,
      "email": email,
      "profileUrl": profileUrl,
      "date": date,
      "isAdmin": isAdmin
    });
  }


  Future<void> saveUser(Users user) async {
    await firestore.collection('users').doc(user.userId).set(user.toMap());
  }

  Future<DocumentSnapshot> singleUserInfo(id) async {
    DocumentSnapshot documentSnapshot = await firestore.collection('users').doc(id).get();
    return documentSnapshot;
  }

  Future<void> updatePhoto(id, picture) async {
    await firestore.collection('users').doc(id).update({"profileUrl": picture});
  }

  Future<void> saveTask(userId, date, title, description, category, status, completed) async {

    final collectionReference = firestore.collection('tasks');
    DocumentReference documentReference = collectionReference.doc();

    await documentReference.set({
      'id': documentReference.id,
      'userId': userId,
      'date': date,
      'title' : title,
      'description': description,
      'category': category,
      'status': status,
      'completed': completed,
      "attendes" : FieldValue.arrayUnion([
        { "uid": userId }
      ]),
    });
  }

  Future<void> deleteTask(taskId) async {
    await firestore.collection('tasks').doc(taskId).delete();
  }

  Future<void> saveEvent(userId, title, description, completed, date, time, address) async {

    final collectionReference = firestore.collection('events');
    DocumentReference documentReference = collectionReference.doc();

      await documentReference.set({
        'id': documentReference.id,
      'userId': userId,
      'title' : title,
      'description': description,
      'completed': completed,
      'date': date,
      'time' : time,
      'address': address
    });
  }

  saveAttendeesEvent(eventId, userId, userName, profileUrl) async {
    await firestore.collection('eventAttendees').doc(eventId).collection('users').add({
      'userId': userId,
      'userName': userName,
      'profileUrl':profileUrl
    });
  }


   Future<List<QueryDocumentSnapshot>> getAttendeesEvent(eventId) async {
    QuerySnapshot querySnapshot = await firestore.collection('eventAttendees').doc(eventId).collection('users').get();
    List<QueryDocumentSnapshot> queryDocumentSnapshot = querySnapshot.docs.map((user) => user).toList();
    return queryDocumentSnapshot;
  }

  Future<List<Event>> singleEventInfo(userId) async {
     QuerySnapshot querySnapshot = await firestore.collection('events').where("userId", isEqualTo: userId).get();
     List<Event> event = querySnapshot.docs.map((event) => Event.fromJson(event)).toList();
     return event;
  }

  Future saveCategory(userId, name) async {
    await firestore.collection('categories').doc().set({
      'name' : name,
      "users" : FieldValue.arrayUnion([
        { "uid": userId }
      ]),
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getTasks()  {
    return firestore.collection('tasks').limit(10).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getEvents()  {
    return firestore.collection('events').limit(5).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getCat()  {
    return firestore.collection('categories').snapshots();
  }

  Future<List<Category>> getCategories() async {
    QuerySnapshot querySnapshot = await firestore.collection('categories').get();
    List<Category> categories = querySnapshot.docs.map((doc) => Category.fromJson(doc)).toList();
    return categories;
  }


  categoryTask(categoryName) async {
    QuerySnapshot querySnapshot =  await FirebaseFirestore.instance.collection('tasks').where("category", isEqualTo: categoryName).get();
    List<Task> tasks = querySnapshot.docs.map((tasks) => Task.fromJson(tasks)).toList();
    return tasks;
  }

    isAdmin(userId) async {
     QuerySnapshot querySnapshot =  await FirebaseFirestore.instance.collection('users').where("userId", isEqualTo: userId).get();
     Object data = querySnapshot.docs.map((user) => user).toList();
     return data;
  }

  Future<Task> getTask(String id) async {
    DocumentSnapshot doc = await firestore.collection('tasks').doc(id).get();
    return Task.fromJson(doc);
  }
  
  Future<int> userTaskLength(userId) async {
    QuerySnapshot querySnapshot = await firestore.collection('tasks').where("userId", isEqualTo: userId).get();
    return querySnapshot.docs.length;
  }

  Future<int> userEventLength(userId) async {
    QuerySnapshot querySnapshot = await firestore.collection('events').where("userId", isEqualTo: userId).get();
    return querySnapshot.docs.length;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> relatedTask(title) async {
     return await FirebaseFirestore.instance.collection('tasks').orderBy("title", descending: false).startAt([title]).limit(10).get();
  }


  Future<void> taskCompleted(id, isCompleted) async {
    await FirebaseFirestore.instance.collection('tasks').doc(id).update({"completed": isCompleted});
  }
  
  Future getTaskList() async {
    QuerySnapshot querySnapshot = await firestore.collection('tasks').get();
    return querySnapshot.docs;
  }


  Future<QuerySnapshot> getUsers() async {
    QuerySnapshot querySnapshot = await firestore.collection('users').get();
    return querySnapshot;
    //List<QueryDocumentSnapshot>  queryDocumentSnapshot = querySnapshot.docs.map((users) => users).toList();
    //return queryDocumentSnapshot;
  }

}
