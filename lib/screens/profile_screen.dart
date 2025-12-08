

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'home_screen.dart';





class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var nameController = TextEditingController();
  var passController = TextEditingController();

  String? storedPassword;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<File?> pickImagefromSource({required ImageSource fromSource}) async {
    final picker = ImagePicker();

    final XFile? pickedFile = await picker.pickImage(
      source: fromSource,
      imageQuality: 70,
    );

    if (pickedFile == null) return null;

    return File(pickedFile.path);
  }

  Future<void> loadUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final doc = await FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .get();

    final data = doc.data();
    if (data == null) return;

    nameController.text = data["Name"] ?? "";
    storedPassword = data["Password"];
  }

  Future<void> updateProfile() async {
    final newName = nameController.text.trim();
    final enteredPassword = passController.text.trim();

    if (enteredPassword.isEmpty) {
      _toast("Enter password");
      return;
    }

    if (enteredPassword != storedPassword) {
      _toast("Wrong password");
      return;
    }

    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "Name": newName,
    });

    _toast("Profile Updated");

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  void _toast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(backgroundColor: Colors.white),

      body: Column(
        children: [
          SizedBox(
            height: 100,
            width: double.infinity,
            child: Image.asset("assets/images/auth_images/Rectangle6.png"),
          ),
          SizedBox(height: 15,),

          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "EDIT PROFILE",
                style: TextStyle(
                  fontFamily: "Dongle",
                  color: Color(0xff305973),
                  fontSize: 40,
                ),
              ),
            ),
          ),
          Stack(
            children: [
              CircleAvatar(
                radius: 70,
                child: Icon(Icons.person ,size: 60, color: Colors.black,),
              ),
              Positioned(
                  bottom: 1,
                  right: 1,
                  child: InkWell(
                      onTap: (){
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Row(
                              children: [
                                InkWell(
                                    onTap: (){
                                      print("camera works");
                                    },
                                    child: Icon(Icons.camera_alt , size: 40, color: Colors.grey,)
                                ),
                                SizedBox(width: 20,),
                                InkWell(
                                    onTap: (){
                                      print("photos works");
                                    },
                                    child: Icon(Icons.photo , size: 40, color: Colors.grey,))
                              ],
                            ))
                        );

                      },
                      child: Icon(Icons.add , color: Colors.black, size: 20,)
                  )
              )
            ],
          ),

          SizedBox(height: 10),

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
                  hint: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    child: Text(
                      "Abhishek",
                      style: TextStyle(
                        color: Color(0xff305973),
                        fontFamily: "Dongle",
                        fontSize: 30,
                      ),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Enter Password",
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
                  hint: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    child: Text(
                      "Confirm its youu",
                      style: TextStyle(
                        color: Color(0xff305973),
                        fontFamily: "Dongle",
                        fontSize: 30,
                      ),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Icon(Icons.remove_red_eye_outlined),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: SizedBox(
              height: 70,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  backgroundColor: Color(0xff305973),
                ),
                onPressed: updateProfile,
                child: Text(
                  "UPDATE",
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
