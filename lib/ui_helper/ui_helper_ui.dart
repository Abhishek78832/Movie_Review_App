import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Uihelper{

  static CustomText(String text , String family , double size , Color color){
    return Text(text ,style: TextStyle(fontSize: size , color: color , fontFamily: family ), );
  }

  static CustonElevatedButton(VoidCallback callback , String name){
    return ElevatedButton(
        onPressed: callback,
        child: Text(name , style: TextStyle(fontFamily: "Dongle" , fontSize: 30 , color: Colors.white),));
  }
}