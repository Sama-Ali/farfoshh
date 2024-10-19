import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farfoshmodi/resources/storage_method.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:typed_data'; //to be able to use Uint8List class
import 'package:farfoshmodi/models/user.dart' as model;
import 'package:flutter/material.dart';

class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // This function fetches the details of the currently logged-in user from Firestore
  Future<model.User> getUserDetails() async {
    try {
      User currentUser = _auth.currentUser!;
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(currentUser.uid).get();

      // Debug: Print the data retrieved
      print('Data fetched: ${snap.data()}');

      // Check if the snapshot has data
      if (snap.exists) {
        return model.User.fromSnap(snap);
      } else {
        throw Exception('User document does not exist');
      }
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        print('User does not have permission to perform this action');
      } else if (e.code == 'not-found') {
        print('Document does not exist');
      } else {
        print('An unknown error occurred: ${e.message}');
      }
      rethrow; // Optionally rethrow the error after logging it
    } catch (e) {
      print('Error: $e');
      rethrow; // Optionally rethrow the error after logging it
    }
  }

  //sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    Uint8List? file,
  }) async {
    String res = "هناك خطأ في المعلومات";
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          file != null) {
        // Register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        print(cred.user!.uid);

        // Check if file is null
        if (file == null) {
          return "Please select an image.";
        }

        // Upload profile image and get its URL
        String photoUrl = await StorageMethod()
            .uploadImageToStorage('profilePics', file, false);

        if (photoUrl.isEmpty) {
          return "Failed to upload profile picture.";
        }

        // Add user to database
        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          followers: [],
          following: [],
          photoUrl: photoUrl,
        );

        await _firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );
        res = "!تم";
      } else {
        res = "جميع الحقو,,ل مطلوبة";
      }
    } catch (err) {
      res = err.toString();
      print(res);
    }
    return res;
  }

  //login user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "هناك خطأ في المعلومات";
    print("test");
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "!تم";
      } else {
        res = "جميع الحقول مطلوبة";
      }
    } on FirebaseAuthException catch (er) {
      if (er.code == 'user-not-found') {
        res = "أدخل معلوماتك بشكل صحيح";
      } else if (er.code == 'wrong-password') {
        res = "كلمة السر غير صحيحة";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
