import 'package:farfoshmodi/Providers/user_provider.dart';
import 'package:farfoshmodi/screens/comments_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:farfoshmodi/widgets/like_animation.dart';
import 'package:farfoshmodi/resources/firestore_method.dart';
import 'package:provider/provider.dart';

const webScreenSize = 600;
const mobileBackgroundColor = Colors.white;
const webBackgroundColor = Colors.grey;
const primaryColor = Colors.black;
const secondaryColor = Color.fromRGBO(160, 160, 160, 100);

class PostCard extends StatefulWidget {
  final snap;
  PostCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int commentLen = 0;
  bool isLikeAnimating = false;
  String? postImageUrl;

  @override
  void initState() {
    super.initState();
    _loadPostImage();
  }

  // Function to load the real-time URL of the image
  Future<void> _loadPostImage() async {
    try {
      // If the post URL is already stored in Firestore
      if (widget.snap['postUrl'] != null && widget.snap['postUrl'] != '') {
        setState(() {
          postImageUrl = widget.snap['postUrl'];
        });
      } else {
        // Example path for fetching the image URL if only the storage path is saved
        final ref = FirebaseStorage.instance.ref(widget.snap['storagePath']);
        String url = await ref.getDownloadURL();
        setState(() {
          postImageUrl = url;
        });
      }
    } catch (e) {
      print("Error fetching post image URL: $e");
      setState(() {
        postImageUrl = 'assets/profile_pic.png'; // Local fallback
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: width > webScreenSize ? secondaryColor : mobileBackgroundColor,
        ),
        color: mobileBackgroundColor,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        children: [
          // HEADER SECTION
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 16,
                  backgroundImage: (widget.snap['profImage'] != null &&
                          widget.snap['profImage'] != '')
                      ? NetworkImage(widget.snap['profImage'])
                      : AssetImage('assets/profile_pic.png') as ImageProvider,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.snap['username'] ?? 'Unknown User',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {
                    // Options Dialog
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shrinkWrap: true,
                          children: ['Delete']
                              .map((e) => InkWell(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 16),
                                      child: Text(e),
                                    ),
                                    onTap: () {},
                                  ))
                              .toList(),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          // IMAGE SECTION
          GestureDetector(
            // onDoubleTap: () {
            //   FirestoreMethod().likePost(
            //     widget.snap['postId'].toString(),
            //     user.uid,
            //     widget.snap['likes'],
            //   );
            //   setState(() {
            //     isLikeAnimating = true;
            //   });
            // },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  child: postImageUrl != null
                      ? Image.network(postImageUrl!, fit: BoxFit.cover)
                      : Image.asset('assets/profile_pic.png',
                          fit: BoxFit.cover),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: LikeAnimation(
                    isAnimating: isLikeAnimating,
                    duration: const Duration(
                      milliseconds: 400,
                    ),
                    onEnd: () {
                      setState(() {
                        isLikeAnimating = false;
                      });
                    },
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 100,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // LIKE, COMMENT SECTION
          Row(
            children: [
              // LikeAnimation(
              //   isAnimating: widget.snap['likes'].contains(user.uid),
              //   smallLike: true,
              //   child: IconButton(
              //     icon: widget.snap['likes'].contains(user.uid)
              //         ? const Icon(
              //             Icons.favorite,
              //             color: Colors.red,
              //           )
              //         : const Icon(
              //             Icons.favorite_border,
              //           ),
              //     onPressed: () => FirestoreMethod().likePost(
              //       widget.snap['postId'].toString(),
              //       user.uid,
              //       widget.snap['likes'],
              //     ),
              //   ),
              // ),
              IconButton(
                icon: Icon(Icons.comment_outlined),
                onPressed: () {
                  final userProvider =
                      Provider.of<UserProvider>(context, listen: false);
                  final user = userProvider.getUser;
                  // Navigate to CommentsScreen
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CommentsScreen(user: user),
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {},
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: Icon(Icons.bookmark_border),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
          // DESCRIPTION AND COMMENTS SECTION
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.snap['likes']?.length ?? 0} likes',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: primaryColor),
                      children: [
                        TextSpan(
                          text: widget.snap['username'] ?? 'Unknown User',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: ' ${widget.snap['description'] ?? ''}',
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      'View all ${widget.snap['comments']?.length ?? 0} comments',
                      style: TextStyle(fontSize: 16, color: secondaryColor),
                    ),
                  ),
                  onTap: () {},
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    DateFormat.yMMMd().format(
                      (widget.snap['datePublished'] as Timestamp?)?.toDate() ??
                          DateTime.now(),
                    ),
                    style: TextStyle(fontSize: 16, color: secondaryColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
