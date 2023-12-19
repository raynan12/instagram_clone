// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:blog/theme/colors.dart';
import 'package:blog/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: SvgPicture.asset(
          'assets/ic_instagram.svg',
          color: primaryColor,
          height: 32,
        ),
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: Icon(
              Icons.messenger_outline,
            ),
          ),
        ],
      ),
      body: PostCard(),
    );
  }
}