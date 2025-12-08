import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled/screens/starting_screen.dart';

import 'home_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  checkLoginStatus(){
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>StartingScreen()));
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed( Duration(seconds: 4) , (){
      checkLoginStatus();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset(
                "assets/review_app.json",
                height: 300,
                width: 300,
                fit: BoxFit.contain
            ),
          ),
        ],
      ),
    );
  }
}
