import 'package:crafty_bay/app/app.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/state_holders/connection_view_model.dart';
import 'core/themes/theme_switcher.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ConnectionViewModel());
  Get.find<ConnectionViewModel>().initialize();
  Get.put(ThemeSwitcher());
  runApp(DevicePreview(enabled: false, builder: (_) => const CraftyBay()));
}
