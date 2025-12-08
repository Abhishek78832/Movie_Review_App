import 'package:flutter/material.dart';
import 'package:untitled/screens/signup_screen.dart';

import 'login_screen.dart';


class StartingScreen extends StatefulWidget {
  const StartingScreen({super.key});

  @override
  State<StartingScreen> createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(height: double.infinity, width: double.infinity),

          SizedBox(
            height: 530,
            width: double.infinity,
            child: Image.asset(
              "assets/images/movie_details/Rectangle1.png",
              height: 530,
              width: double.infinity,
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            top: 300,
            bottom: 0,
            child: Container(
              height: 700,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 340,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Image.asset("assets/images/auth_images/Rectangle6.png"),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 38.0),
                      child: Text(
                        "FOR MOVIES LOVERS BY MOVIES LOVERS ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          fontFamily: "Dongle",
                          color: Color(0xff002B5B),
                        ),
                        maxLines: 2,
                      ),
                    ),

                    Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: Text(
                              "EXOLORE",
                              style: TextStyle(
                                fontFamily: "Dongle",
                                fontSize: 40,
                                color: Color(0xff305973),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: Text(
                              "DISCONNECT",
                              style: TextStyle(
                                fontFamily: "Dongle",
                                fontSize: 40,
                                color: Color(0xff305973),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: Text(
                              "DISCOVER",
                              style: TextStyle(
                                fontFamily: "Dongle",
                                fontSize: 40,
                                color: Color(0xff305973),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),

                    SizedBox(
                      height: 65,
                      width: 320,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff305973),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){return LoginScreen();}));
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 40,
                            fontFamily: "Dongle",
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){return SignupScreen();}));
                      },
                      child: Text("Register" , style: TextStyle(fontWeight: FontWeight.bold ,
                          fontFamily: "Dongle" , color: Color(0xff305973) , fontSize: 40),),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
