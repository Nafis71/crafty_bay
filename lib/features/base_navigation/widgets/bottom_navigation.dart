import 'package:crafty_bay/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_assets.dart';
import '../../product_details/state_holders/product_state.dart';
import '../state_holders/base_navigation_state.dart';
import 'bottom_navigation_bar_item.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BaseNavigationState>(builder: (baseNavigationViewModel) {
      return BottomNavigationBar(
        currentIndex: baseNavigationViewModel.index,
        onTap: (index) {
          if (baseNavigationViewModel.index == index ||
              Get.find<ProductState>().isAddingToCart) {
            return;
          }
          baseNavigationViewModel.setIndex = index;
        },
        items: [
          getBottomNavigationBarItem(
            index: baseNavigationViewModel.index,
            targetIndex: 0,
            context: context,
            label: AppStrings.homeNavigationTabText,
            iconPath: AppAssets.homeIcon,
          ),
          getBottomNavigationBarItem(
            index: baseNavigationViewModel.index,
            targetIndex: 1,
            context: context,
            label: AppStrings.categoryNavigationTabText,
            iconPath: AppAssets.categoryIcon,
          ),
          getBottomNavigationBarItem(
            index: baseNavigationViewModel.index,
            targetIndex: 2,
            context: context,
            label: AppStrings.cartNavigationTabText,
            iconPath: AppAssets.cartIcon,
          ),
          getBottomNavigationBarItem(
            index: baseNavigationViewModel.index,
            targetIndex: 3,
            context: context,
            label: AppStrings.wishListNavigationTabText,
            iconPath: AppAssets.giftIcon,
          ),
        ],
      );
    });
  }
}
