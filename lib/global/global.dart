import 'package:blog/screen/add_post_screen.dart';
import 'package:blog/screen/feed_screen.dart';
import 'package:flutter/cupertino.dart';

List<Widget> homeScreenItem = [
  FeedScreen(),
  Text('search'),
  AddPostScreen(),
  Text('notif'),
  Text('profile'),
];