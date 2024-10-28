import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farfoshmodi/Providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:farfoshmodi/models/user.dart' as model;

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  @override
  Widget build(BuildContext context) {
    // UserProvider provider = Provider.of<UserProvider>(context);
    // provider.refreshUser();
    // model.User? user = provider.getUser;
    // print("getting the user from web screeeeeeeeeeeen");
    // print(user);
    return Scaffold(
      body: Center(
        // child: Text(user!.username),
        child: Text("user!.username"),
      ),
    );
  }
}
