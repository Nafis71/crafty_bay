import 'package:crafty_bay/app/app.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/services/network_service/network_state.dart';
import 'core/themes/theme_switcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializePrerequisite();
  bool? isDarkModeEnabled = await loadTheme();
  runApp(
    DevicePreview(
      enabled: false,
      builder: (_) => CraftyBay(
        isDarkModeEnabled: isDarkModeEnabled,
      ),
    ),
  );
}

void initializePrerequisite() {
  Get.put(NetworkState());
  Get.find<NetworkState>().initialize();
  Get.put(ThemeSwitcher());
}

Future<bool?> loadTheme() async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  return localStorage.getBool("isDarkModeEnabled");
}
