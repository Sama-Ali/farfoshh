import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethod {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //add image to firebase storage
  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    //ref() point to file reference in our Storage even exist or not
    //our profile pics will be saved in folders such like: profilePic/uid/file
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(file); //put the pic

    TaskSnapshot snap = await uploadTask;
    //URL to be saved in database and shown to ather users:
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
