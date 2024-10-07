import 'package:crafty_bay/core/widgets/crafty_app_bar.dart';
import 'package:flutter/material.dart';

class ProfileUpdationView extends StatefulWidget {
  final String profileUpdationType;
  const ProfileUpdationView({super.key, required this.profileUpdationType});

  @override
  State<ProfileUpdationView> createState() => _ProfileUpdationViewState();
}

class _ProfileUpdationViewState extends State<ProfileUpdationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: craftyAppBar(title: widget.profileUpdationType,context: context),
    );
  }
}
