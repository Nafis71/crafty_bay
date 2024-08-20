import 'package:crafty_bay/app/app.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'common/view_model/connection_view_model.dart';

void main() {
  Get.put(ConnectionViewModel());
  Get.find<ConnectionViewModel>().initialize();
  runApp(DevicePreview(builder: (_) => const CraftyBay()));
}
