import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_management/model/user.dart';

class FireStoreDatabase {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> saveUser(Users user) async {
    await firestore.collection('users').doc(user.userId).set(user.toMap());
  }
}
