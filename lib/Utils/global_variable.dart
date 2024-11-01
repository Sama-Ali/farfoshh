import 'package:farfoshmodi/Providers/user_provider.dart';
import 'package:farfoshmodi/screens/feed_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const webScreenSize = 600;
List<Widget> homeScreenItems = [
  Builder(
    builder: (context) {
      try {
        Provider.of<UserProvider>(context, listen: false);
        print('UserProvider accessible in global');
      } catch (e) {
        print('UserProvider not accessible in global: $e');
      }
      return const FeedScreen();
    },
  ),
  Center(child: Text('SEARCH')),
  Center(child: Text('FARFOSH')),
  Center(child: Text('CHAT')),
  Center(child: Text('profile')),
];
