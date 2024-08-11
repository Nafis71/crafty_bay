import 'package:crafty_bay/features/base_navigation/view_model/base_navigation_view_model.dart';
import 'package:crafty_bay/features/base_navigation/widgets/bottom_navigation.dart';
import 'package:crafty_bay/utils/app_assets.dart';
import 'package:crafty_bay/wrappers/svg_image_loader.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../widgets/bottom_navigation_bar_item.dart';

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
