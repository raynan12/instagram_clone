// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, empty_catches, use_build_context_synchronously
import 'dart:typed_data';
// import 'package:blog/firebase/firebase_methods.dart';
import 'package:blog/providers/user_provider.dart';
import 'package:blog/theme/colors.dart';
import 'package:blog/utils/utils.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../resources/firestore_methods.dart';

// import '../models/user_model.dart';


class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();
  bool isLoading = false;

  
  void postImage(String uid, String username, String profImage) async {
    setState(() {
      isLoading = true;
    });
    // start the loading
    try {
      // upload to storage and db
      String res = await FireStoreMethods().uploadPost(
        _descriptionController.text,
        _file!,
        uid,
        username,
        profImage,
      );
      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        showsnackBar(
          context,
          'Posted!',
        );
        clearImage();
      } else {
        showsnackBar(context, res);
      }
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      showsnackBar(
        context,
        err.toString(),
      );
    }
  }

  _selectImage(BuildContext context) async {
    return showDialog(context: context, builder: (context) {
      return SimpleDialog(
        title: Text('Create a post'),
        children: [
          SimpleDialogOption(
            padding: EdgeInsets.all(20),
            child: Text('Take a photo'),
            onPressed: () async {
              Navigator.of(context).pop();
              Uint8List file = await pickImage(
                ImageSource.camera,
              );
              setState(() {
                _file = file;
              });
            },
          ),
          SimpleDialogOption(
            padding: EdgeInsets.all(20),
            child: Text('Choose from gallery'),
            onPressed: () async {
              Navigator.of(context).pop();
              Uint8List file = await pickImage(
                ImageSource.gallery,
              );
              setState(() {
                _file = file;
              });
            },
          ),
           SimpleDialogOption(
            padding: EdgeInsets.all(20),
            child: Text('Cancel'),
            onPressed: () async {
              Navigator.of(context).pop(); 
            },
          ),
        ],
      );
    });
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context); 

    return _file == null
      ? Center(
        child: IconButton(
          icon: Icon(Icons.upload),
          onPressed: () => _selectImage(context), 
        ),
      )
    : Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: clearImage, 
        ),
        title: Text('Post to'),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () => postImage(
              userProvider.getUser.uid,
              userProvider.getUser.username,
              userProvider.getUser.photoUrl,
            ), 
            child: Text(
              'Post',
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          isLoading 
              ? LinearProgressIndicator(color: Colors.red,) 
              : Padding(
                padding: EdgeInsets.only(top: 0),
              ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CircleAvatar(
              //   backgroundImage: NetworkImage(
              //     userProvider.getUser.photoUrl
              //   ),
              // ),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.45,
                child: TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Write a caption...',
                    border: InputBorder.none,
                  ),
                  maxLines: 8,
                ),
              ),
              SizedBox(
                height: 45,
                width: 45,
                child: AspectRatio(
                  aspectRatio: 487 / 451,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: MemoryImage(_file!),
                        fit: BoxFit.fill,
                        alignment: FractionalOffset.topCenter,
                      ),
                    ),
                  ),
                ),
              ),
              Divider(),
            ],
          ),
        ],
      ),
    );
  }
}