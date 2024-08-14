import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../utils/app_assets.dart';
import '../view_model/base_navigation_view_model.dart';
import 'bottom_navigation_bar_item.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: GetBuilder<BaseNavigationViewModel>(
          builder: (baseNavigationViewModel) {
        return BottomNavigationBar(
          currentIndex: baseNavigationViewModel.index,
          useLegacyColorScheme: false,
          backgroundColor: Colors.white,
          elevation: 15,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(
            fontSize: 11,
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 11,
            fontFamily: "Poppins",
          ),
          onTap: (index) {
            baseNavigationViewModel.setIndex = index;
          },
          items: [
            getBottomNavigationBarItem(
              index: baseNavigationViewModel.index,
              targetIndex: 0,
              context: context,
              label: "Home",
              iconPath: AppAssets.homeIcon,
            ),
            getBottomNavigationBarItem(
              index: baseNavigationViewModel.index,
              targetIndex: 1,
              context: context,
              label: "Category",
              iconPath: AppAssets.categoryIcon,
            ),
            getBottomNavigationBarItem(
              index: baseNavigationViewModel.index,
              targetIndex: 2,
              context: context,
              label: "Cart",
              iconPath: AppAssets.cartIcon,
            ),
            getBottomNavigationBarItem(
              index: baseNavigationViewModel.index,
              targetIndex: 3,
              context: context,
              label: "Wish",
              iconPath: AppAssets.giftIcon,
            ),
          ],
        );
      }),
    );
  }
}
