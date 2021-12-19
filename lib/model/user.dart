import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Users  {
  String? userId;
  String? email;
  String? userName;
  String? profileUrl;
  DateTime? date;
  bool? isAdmin = false;

  Users ({
    required this.userId,
      required this.email,
      this.userName,
      this.profileUrl,
      this.date,
      this.isAdmin});

  factory Users.generateUser(User user){
    return Users(userId: user.uid, email: user.email, userName: user.displayName);
  }


  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'userName' : userName,
      'profileUrl': profileUrl,
      'date': date ?? FieldValue.serverTimestamp(),
      'isAdmin': isAdmin ?? false
    };
  }
}
