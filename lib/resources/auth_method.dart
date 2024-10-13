import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farfoshmodi/resources/storage_method.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:typed_data'; //to be able to use Uint8List class
import 'package:farfoshmodi/models/user.dart' as model;

class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //sign up user
  Future<String> signUpUser(
      {required String email,
      required String password,
      required String username,
      // required String bio,
      // required int age,
      // required List<String> hobbies,
      Uint8List? file //profile pic
      }) async {
    String res = "هناك خطأ في المعلومات";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          // bio.isNotEmpty||
          // age > 0 ||
          // hobbies.isNotEmpty
          file != null) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            //UserCredential cred: Stores user details & metadata.
            email: email,
            password: password);

        print(cred.user!.uid);
        //cred is UserCredential object returned by Firebase after creating user

        // String photoUrl = await StorageMethod()
        //     .uploadImageToStorage('profilePics', file, false);
        //add user to database

        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          followers: [],
          following: [],
          // photoUrl: photoUrl
        );
        await _firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );
        res = "!تم";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'أدخل ايميلك بشكل صحيح';
      } else if (err.code == 'weak-password') {
        res = 'كلمة السر يجب أن تكون 6 خانات على الأقل';
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
