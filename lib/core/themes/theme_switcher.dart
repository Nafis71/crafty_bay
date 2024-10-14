import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_color.dart';

class ThemeSwitcher extends GetxController {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  set setThemeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    saveConfig();
    update();
  }

  set setThemeModeSilently(ThemeMode themeMode) {
    _themeMode = themeMode;
  }

  Color getComponentColor() {
    if (_themeMode == ThemeMode.dark) {
      return AppColor.darkComponentsColor;
    }
    return Colors.white;
  }

  Color getAppBarActionButtonColor() {
    if (_themeMode == ThemeMode.dark) {
      return AppColor.appBarActionButtonColorDark;
    }
    return AppColor.appBarActionButtonColorLight;
  }

  Color getSearchBarColor() {
    if (_themeMode == ThemeMode.dark) {
      return AppColor.darkComponentsColor;
    }
    return AppColor.searchBarBackgroundColor;
  }

  Future<void> saveConfig() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    if (_themeMode == ThemeMode.dark) {
      localStorage.setBool("isDarkModeEnabled", true);
    } else {
      localStorage.setBool("isDarkModeEnabled", false);
    }
  }
}
