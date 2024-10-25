//this file for save post in firebase
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farfoshmodi/models/post.dart';
import 'package:farfoshmodi/resources/storage_method.dart';
import 'dart:typed_data';
import 'package:uuid/uuid.dart';
import 'package:flutter/foundation.dart';

class FirestoreMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post
  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profImage,
  ) async {
    String res = "هناك خطأ";
    try {
      String photoUrl =
          await StorageMethod().uploadImageToStorage('posts', file, true);
      //using method provided by uuid package:
      //v1 using to create unique identefier based on the time
      String postId = const Uuid().v1();
      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: profImage,
        likes: [],
      );

      //upload post to firebase
      _firestore.collection('posts').doc(postId).set(
            post.toJson(),
          );
      res = "!تم";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
