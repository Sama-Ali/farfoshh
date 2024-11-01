import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farfoshmodi/models/user.dart';
import 'package:farfoshmodi/widgets/comment_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const mobileBackgroundColor = Colors.white;
const webBackgroundColor = Colors.grey;
const primaryColor = Colors.black;
const secondaryColor = Color.fromRGBO(160, 160, 160, 100);

class CommentsScreen extends StatefulWidget {
  final User? user;
  const CommentsScreen({Key? key, required this.user}) : super(key: key);

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController commentEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text(
          'Comments',
        ),
        centerTitle: false,
      ),
      // text input
      body: CommentCard(),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://images.pexels.com/photos/10583179/pexels-photo-10583179.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                radius: 18,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 8),
                  child: TextField(
                    controller: commentEditingController,
                    decoration: InputDecoration(
                      hintText: 'Comment as',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: const Text(
                    'Post',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
