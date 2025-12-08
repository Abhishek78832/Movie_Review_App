import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return showProfile();
  }

  showProfile()async{
    return showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            actions: [
              Stack(
                children: [
                  Container(
                    height: 535 ,
                    width: double.infinity,
                    color: Colors.white,
                  )
                ],
              )
            ],
          );
        });
  }


}
