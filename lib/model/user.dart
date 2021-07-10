import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Users  {
  final String userId;
  String? email;
  String? userName;
  String? profileUrl;
  DateTime? createdDate;
  DateTime? updateDate;
  bool? isAdmin = false;

  Users (
      {required this.userId,
      required this.email,
      this.userName,
      this.profileUrl,
      this.createdDate,
      this.updateDate,
      this.isAdmin});



  factory Users.generateUser(User user){
      return Users(userId: user.uid, email: user.email);
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'userName': userName,
      'profileUrl': profileUrl,
      'createdDate': createdDate ?? FieldValue.serverTimestamp(),
      'updateDate': updateDate ?? FieldValue.serverTimestamp(),
      'isAdmin': isAdmin ?? false
    };
  }
}
