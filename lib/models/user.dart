import 'package:firebase_auth/firebase_auth.dart';

class User {
  final String username;
  final String uid;
  final String email;
  final List followers;
  final List following;
  final String? photoUrl;

  const User({
    required this.username,
    required this.uid,
    required this.email,
    required this.followers,
    required this.following,
    this.photoUrl,
  });

  //conver user to object
  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'email': email,
        'followers': followers,
        'following': following,
        'photoUrl': photoUrl,
      };
}
