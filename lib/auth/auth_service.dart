import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_management/model/user.dart';

class AuthenticationService extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;

  AuthenticationService(this._auth);

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  String? get getCurrentUID => _auth.currentUser!.uid;

  String? get getUsername => _auth.currentUser!.displayName;

  String? get getPhoto => _auth.currentUser!.photoURL;

  String? get getEmail => _auth.currentUser!.email;


  Users? _userCreate(User? user) {
    return user == null ? null : Users.generateUser(user);
  }

  Future<Users?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      notifyListeners();

      User? user = _auth.currentUser;

      await user!.sendEmailVerification();

      if (_auth.currentUser != null) {
        print("confirmation email sent");
        await _auth.signOut();
        print("logged out");
      }

     return  _userCreate(userCredential.user);

    } on FirebaseAuthException catch (e) {
      print(e);
    }

  }

  Future<Users?> signIn(
      {required String email, required String password}) async {
    try {
      if (_auth.currentUser == null) {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
        notifyListeners();

        var loginUser = userCredential.user;

       /* if (loginUser!.emailVerified) {
          print("email confirmed");
        } else {
          await _auth.signOut();
          print("email not confirmed");
        }*/

        print("Signed in");
      }
    } on FirebaseAuthException catch (e) {
      var errorCode = e.code;
      var errorMessage = e.message;

      if (errorCode == 'auth/wrong-password') {
        print("Wrong Password.");
      } else {
        print(e.toString());
      }
    }
  }

  Future<void> photoUpdate(String picture) async {
    await _auth.currentUser!.updatePhotoURL(picture);
  }

  Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners();
  }

}
