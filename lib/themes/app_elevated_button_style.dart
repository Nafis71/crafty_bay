import 'package:crafty_bay/themes/app_color.dart';
import 'package:flutter/material.dart';

class AppElevatedButtonStyle{
 static ElevatedButtonThemeData getElevatedButton()=> ElevatedButtonThemeData(
   style: ElevatedButton.styleFrom(
     minimumSize: const Size(double.infinity, 48),
     backgroundColor: AppColor.appPrimaryColor,
     foregroundColor: Colors.white,
     shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(5),
     ),
     textStyle: const TextStyle(
       fontFamily: "Poppins",
       fontSize: 15,
       fontWeight: FontWeight.bold,
       letterSpacing: 0.5
     )
   )
 );
}