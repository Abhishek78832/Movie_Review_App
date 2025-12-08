import 'package:flutter/material.dart';

import 'package:untitled/screens/reset_password_screen.dart';

class VerifyMailScreen extends StatefulWidget {
  const VerifyMailScreen({super.key});

  @override
  State<VerifyMailScreen> createState() => _VerifyMailScreenState();
}

class _VerifyMailScreenState extends State<VerifyMailScreen> {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // appbar
      appBar: AppBar(backgroundColor: Colors.white),

      // body
      body: Column(
        children: [
          SizedBox(
            height: 100,
            width: double.infinity,
            child: Image.asset("assets/images/auth_images/Rectangle6.png"),
          ),
          SizedBox(height: 60,),

          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "UPDATE PASSWORD",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "Dongle",
                  color: Color(0xff305973),
                  fontSize: 40,
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "FORGOT YOUR PASSWORD",
                style: TextStyle(
                  fontFamily: "Dongle",
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
            ),
          ),

          SizedBox(height: 60),

          // email textfield
          Padding(
            padding: const EdgeInsets.only(left: 120.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Enter your email",
                style: TextStyle(
                  fontFamily: "Dongle",
                  color: Colors.black,
                  fontSize: 35,
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: SizedBox(
              height: 60,
              width: double.infinity,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hint: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    child: Text(
                      "Enter email...",
                      style: TextStyle(
                        color: Color(0xff305973),
                        fontFamily: "Dongle",
                        fontSize: 30,
                      ),
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 20),


          Padding(
            padding: const EdgeInsets.only(left:40.0),
            child: SizedBox(
              height: 40,
              child: Text(
                "we've sent your a verification mail",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontFamily: "Quicksand",
                ),
              ),
            ),
          ),
          SizedBox(height: 50),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: SizedBox(
              height: 70,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)
                  ),
                  backgroundColor: Color(0xff305973),
                ),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){return ResetPasswordScreen();}));
                },
                child: Text(
                  "Verify",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Dongle",
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
