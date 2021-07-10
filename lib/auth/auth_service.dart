import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_management/services/database.dart';
import 'package:task_management/model/user.dart';

class AuthenticationService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Users? _userFromFirebaseUser(User? user) {
    return user != null ? Users.generateUser(user) : null;
  }

  Future<Users?> signUp(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      User? user = _auth.currentUser;

      await user!.sendEmailVerification();

      if (_auth.currentUser != null) {
        print("confirmation email sent");
        await _auth.signOut();
        print("logged out");
      }

      return _userFromFirebaseUser(user);

    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      if (_auth.currentUser == null) {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        var loginUser = userCredential.user;

        if (loginUser!.emailVerified) {
          print("email confirmed");
        } else {
          await _auth.signOut();
          print("email not confirmed");
        }

        return "Signed in";
      }
    } on FirebaseAuthException catch (e) {
      var errorCode = e.code;
      var errorMessage = e.message;

      if (errorCode == 'auth/wrong-password') {
        return ('Wrong Password.');
      } else {
        return "errorMessage";
      }
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
