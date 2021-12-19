import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageServices {
  Reference _reference = FirebaseStorage.instance.ref();
  String? pictureId;

  // No App Check token for request.
  Future<String> loadPicture(File file) async {
    pictureId = Uuid().v4();
    UploadTask uploadTask =  _reference.child("images/profil/profil_$pictureId.jpg").putFile(file);

    TaskSnapshot taskSnapshot = await uploadTask;

    String loadImage = await taskSnapshot.ref.getDownloadURL();
    return loadImage;

  }
}