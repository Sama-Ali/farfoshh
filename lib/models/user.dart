//this file built for keep user ingfo
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  final String uid;
  final String email;
  final List followers;
  final List following;
  final String photoUrl; // Make sure this is nullable

  const User({
    required this.username,
    required this.uid,
    required this.email,
    required this.followers,
    required this.following,
    required this.photoUrl,
  });

  // Convert user to a map (JSON format)
  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'email': email,
        'followers': followers,
        'following': following,
        'photoUrl': photoUrl,
      };

  // Take a document snapshot and return user model
  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot['username'],
      uid: snapshot['uid'],
      email: snapshot['email'],
      followers: snapshot['followers'],
      following: snapshot['following'],
      photoUrl: snapshot['photoUrl'] ??
          'https://images.pexels.com/photos/28704265/pexels-photo-28704265/free-photo-of-parisian-cafe-window-display-with-wine-and-meat-specialties.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load', // Provide a default value if null
    );
  }
}
