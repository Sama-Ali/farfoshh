import 'package:farfoshmodi/screens/add_post_screen.dart';
import 'package:farfoshmodi/widgets/post_card.dart';
import 'package:flutter/material.dart';

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
          // Add your main content here
          const PostCard(),
          // Custom Positioned Floating Action Button
          Positioned(
            bottom: 30, // Position the button higher from the bottom
            right: 20, // Right padding to align with the screen edge
            child: SizedBox(
              width: 50, // Smaller width
              height: 50, // Smaller height
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddPostScreen()),
                  );
                },
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
