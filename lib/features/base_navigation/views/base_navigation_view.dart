import 'package:crafty_bay/features/base_navigation/view_model/base_navigation_view_model.dart';
import 'package:crafty_bay/features/base_navigation/widgets/bottom_navigation.dart';
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
      body: GetBuilder<BaseNavigationViewModel>(
        builder: (baseNavigationViewModel) {
          return PageView.builder(
            onPageChanged: (int index) {
              baseNavigationViewModel.setIndex = index;
            },
            itemBuilder: (context, index) {
              return baseNavigationViewModel.views[index];
            },
          );
        },
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
