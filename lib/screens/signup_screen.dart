import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';



class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var confirmPassController = TextEditingController();

  void signInUser({required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await addUserInfoToFireStore();
      print("signup successfully done!!!");
      print("user info added successfully!!!");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){return HomeScreen();}));

    } catch (e) {
      print("Sign-in failed: $e");
      return null;
    }
    return null;
  }

  Future<void> addUserInfoToFireStore()  async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      await FirebaseFirestore.instance.collection("Users")
          .doc(user.uid)
          .set({
        "uid" : FirebaseAuth.instance.currentUser!.uid,
        "Name": nameController.text.trim(),
        "Email": emailController.text.trim(),
        "Password" : passController.text.trim()
      });
      print("User info added successfully, uid = ${user.uid}");
    } catch (e) {
      print("Failed to add user info: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5E9CF),
      appBar: AppBar(
        backgroundColor: Color(0xffF5E9CF),
      ),

      // body
      body: Column(
        children: [
          SizedBox(
            height: 100,
            width: double.infinity,
            child: Image.asset("assets/images/auth_images/img.png" ,),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "REGISTER",
                style: TextStyle(
                  fontFamily: "Dongle",
                  color: Color(0xff305973),
                  fontSize: 40,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "JOIN US",
                style: TextStyle(
                  fontFamily: "Dongle",
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
            ),
          ),

          // user name textfield
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Username",
                style: TextStyle(
                  fontFamily: "Dongle",
                  color: Colors.black,
                  fontSize: 35,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: SizedBox(
              height: 60,
              width: double.infinity,
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hint: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    child: Text(
                      "Enter your name",
                      style: TextStyle(
                        color: Color(0xff305973),
                        fontFamily: "Dongle",
                        fontSize: 30,
                      ),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.white), // white border
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.white), // white border
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),

          // email textfield
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Email",
                style: TextStyle(
                  fontFamily: "Dongle",
                  color: Colors.black,
                  fontSize: 35,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: SizedBox(
              height: 60,
              width: double.infinity,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hint: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    child: Text(
                      "Enter your email",
                      style: TextStyle(
                        color: Color(0xff305973),
                        fontFamily: "Dongle",
                        fontSize: 30,
                      ),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.white), // white border
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.white), // white border
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),

          // password textfield
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Password",
                style: TextStyle(
                  fontFamily: "Dongle",
                  color: Colors.black,
                  fontSize: 35,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: SizedBox(
              height: 60,
              width: double.infinity,
              child: TextField(
                controller: passController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hint: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    child: Text(
                      "Enter your password",
                      style: TextStyle(
                        color: Color(0xff305973),
                        fontFamily: "Dongle",
                        fontSize: 30,
                      ),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.white), // white border
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.white), // white border
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Icon(Icons.remove_red_eye_outlined),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),

          // confirm password textfield
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Confirm Password",
                style: TextStyle(
                  fontFamily: "Dongle",
                  color: Colors.black,
                  fontSize: 35,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: SizedBox(
              height: 60,
              width: double.infinity,
              child: TextField(
                controller: confirmPassController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hint: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    child: Text(
                      "Confirm Password",
                      style: TextStyle(
                        color: Color(0xff305973),
                        fontFamily: "Dongle",
                        fontSize: 30,
                      ),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.white), // white border
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.white), // white border
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Icon(Icons.remove_red_eye_outlined),
                  ),
                ),

              ),
            ),
          ),
          SizedBox(height: 30,),

          // register button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: SizedBox(
              height: 70,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff305973),
                ),
                onPressed: () {
                  signInUser(email: emailController.text.toString(), password: passController.text.toString());
                },
                child: Text(
                  "REGISTER",
                  style: TextStyle(
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
