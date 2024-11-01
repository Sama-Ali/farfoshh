import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farfoshmodi/Providers/user_provider.dart';
import 'package:farfoshmodi/screens/add_post_screen.dart';
import 'package:farfoshmodi/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const webScreenSize = 600;
const mobileBackgroundColor = Colors.white;
const webBackgroundColor = Colors.grey;
const primaryColor = Colors.black;

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    print("**********in feedScreen");

    return Scaffold(
      backgroundColor:
          width > webScreenSize ? webBackgroundColor : mobileBackgroundColor,
      appBar: width > webScreenSize
          ? null
          : AppBar(
              backgroundColor: mobileBackgroundColor,
              centerTitle: false,
              title: Image.asset(
                'assets/app_logo.png',
                height: 32,
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.messenger_outline,
                    color: primaryColor,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
      body: Stack(
        children: [
          // for backend:
          StreamBuilder(
            //StreamBuilder rebuild its UI with the new data
            stream: FirebaseFirestore.instance
                .collection('posts')
                .snapshots(), //.snapshots() provide real time changes in 'post' collection
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) => PostCard(
                  snap: snapshot.data!.docs[index].data(),
                ),
              );
            },
          ),
          // Custom Positioned Floating Action Button
          Positioned(
            bottom: 30, // Position the button higher from the bottom
            right: 20, // Right padding to align with the screen edge
            child: SizedBox(
              width: 50, // Smaller width
              height: 50, // Smaller height
              child: FloatingActionButton(
                onPressed: () {
                  final userProvider =
                      Provider.of<UserProvider>(context, listen: false);
                  final user = userProvider.getUser;
                  // final UserProvider userProvider =
                  //     Provider.of<UserProvider>(context);
                  print("in feedScreen");
                  // print(userProvider.getUser);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddPostScreen(user: user)),
                  );
                },
                // Navigator.push(context, AddPostScreen())},
                backgroundColor: Colors.white, // White background
                elevation: 4, // Small shadow for a subtle effect
                child: Icon(
                  Icons.add,
                  color:
                      const Color.fromRGBO(27, 37, 67, 0.612), // Black "+" icon
                  size: 24, // Smaller icon size
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
