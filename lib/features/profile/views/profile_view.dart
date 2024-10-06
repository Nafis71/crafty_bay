import 'package:crafty_bay/core/view_model/profile_view_model.dart';
import 'package:crafty_bay/core/widgets/crafty_app_bar.dart';
import 'package:crafty_bay/features/profile/widgets/profile_overview.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    checkTokenValidity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: craftyAppBar(title: "Profile", context: context),
      body: GetBuilder<ProfileViewModel>(
        builder: (profileViewModel) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(30),
                ProfileOverview(profileViewModel: profileViewModel),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> checkTokenValidity() async {}
}
