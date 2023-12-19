// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:blog/layout/responsive_layout.dart';
import 'package:blog/mobile/mobile_screen.dart';
import 'package:blog/providers/user_provider.dart';
import 'package:blog/screen/login_screen.dart';
import 'package:blog/screen/sigin_screen.dart';
import 'package:provider/provider.dart';
import 'package:blog/theme/colors.dart';
import 'package:blog/web/web_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if(kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyBItxPLLfIEE3_BCnZkyOqUeu1b4-nIKe4",
        authDomain: "blog31a36.firebaseapp.com",
        projectId: "blog31a36",
        storageBucket: "blog31a36.appspot.com",
        messagingSenderId: "630378831203",
        appId: "1:630378831203:web:ab33bfb9cdb511c90e8756"
    ));
  } else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Blog',
        theme: ThemeData(
          scaffoldBackgroundColor: primaryColor,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.active) {
              if(snapshot.hasData) {
                return ResponsiveLayout(
                  mobileScreenLayout: MobileScreen(),
                  webScreenLayout: WebScreen(), 
                );
              } else if(snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if(snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
            return LoginScreen();
          },
        ),
      ),
    );
  }
}

/*
// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyBItxPLLfIEE3_BCnZkyOqUeu1b4-nIKe4",
  authDomain: "blog31a36.firebaseapp.com",
  projectId: "blog31a36",
  storageBucket: "blog31a36.appspot.com",
  messagingSenderId: "630378831203",
  appId: "1:630378831203:web:ab33bfb9cdb511c90e8756"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
*/