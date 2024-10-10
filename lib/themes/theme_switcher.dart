import 'package:crafty_bay/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeSwitcher extends GetxController{
  ThemeMode _themeMode = ThemeMode.dark;


  ThemeMode get themeMode => _themeMode;

  set setThemeMode(ThemeMode themeMode){
    _themeMode = themeMode;
    update();
  }

  Color getComponentColor(){
    if(_themeMode == ThemeMode.dark){
      return AppColor.darkComponentsColor;
    }
    return Colors.white;
  }

  Color getAppBarActionButtonColor(){
    if(_themeMode == ThemeMode.dark){
      return AppColor.appBarActionButtonColorDark;
    }
    return AppColor.appBarActionButtonColorLight;
  }

}