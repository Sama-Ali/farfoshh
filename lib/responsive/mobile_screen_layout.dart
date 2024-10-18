import 'package:farfoshmodi/Utils/global_variable.dart';
import 'package:farfoshmodi/screens/add_post_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: onPageChanged,
            children: homeScreenItems,
          ),
          // Custom Positioned Floating Action Button
          Positioned(
            bottom: 30, // Position the button higher from the bottom
            right: 20, // Right padding to align with the screen edge
            child: Container(
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
                child: Icon(
                  Icons.add,
                  color:
                      const Color.fromRGBO(27, 37, 67, 0.612), // Black "+" icon
                  size: 24, // Smaller icon size
                ),
                elevation: 4, // Small shadow for a subtle effect
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: (_page == 0)
                  ? const Color.fromRGBO(32, 175, 161, 100)
                  : const Color.fromRGBO(160, 160, 160, 100),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: (_page == 1)
                  ? const Color.fromRGBO(32, 175, 161, 100)
                  : const Color.fromRGBO(160, 160, 160, 100),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 40, // Ensuring the icon is centered correctly
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white, // Circle background color
              ),
              child: Image.asset(
                'assets/farfoshicon.png', // Replace with your image asset path
                fit: BoxFit.contain,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
              color: (_page == 3)
                  ? const Color.fromRGBO(32, 175, 161, 100)
                  : const Color.fromRGBO(160, 160, 160, 100),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: (_page == 4)
                  ? const Color.fromRGBO(32, 175, 161, 100)
                  : const Color.fromRGBO(160, 160, 160, 100),
            ),
            label: '',
          ),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }
}
