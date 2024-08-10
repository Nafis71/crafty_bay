import 'package:crafty_bay/view_models/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseNavigationView extends StatefulWidget {
  const BaseNavigationView({super.key});

  @override
  State<BaseNavigationView> createState() => _BaseNavigationViewState();
}

class _BaseNavigationViewState extends State<BaseNavigationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  Center(
        child: Text(Get.find<ProfileViewModel>().userModel.firstName.toString()),
      ),
    );
  }
}
