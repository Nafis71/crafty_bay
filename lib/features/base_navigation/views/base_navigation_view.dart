import 'package:crafty_bay/features/base_navigation/view_model/base_navigation_view_model.dart';
import 'package:crafty_bay/utils/app_assets.dart';
import 'package:crafty_bay/wrappers/svg_image_loader.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
      bottomNavigationBar: Theme(
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
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Column(
                      children: [
                        SvgImageLoader(
                          assetLocation: AppAssets.homeIcon,
                          boxFit: BoxFit.cover,
                          width: 35,
                          color: (baseNavigationViewModel.index == 0)
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Column(
                      children: [
                        SvgImageLoader(
                          assetLocation: AppAssets.categoryIcon,
                          boxFit: BoxFit.contain,
                          width: 33,
                          color: (baseNavigationViewModel.index == 1)
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  label: "Category"),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Column(
                    children: [
                      SvgImageLoader(
                        assetLocation: AppAssets.cartIcon,
                        boxFit: BoxFit.contain,
                        width: 33,
                        color: (baseNavigationViewModel.index == 2)
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                    ],
                  ),
                ),
                label: "Cart",
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Column(
                    children: [
                      SvgImageLoader(
                        assetLocation: AppAssets.giftIcon,
                        boxFit: BoxFit.contain,
                        width: 33,
                        color: (baseNavigationViewModel.index == 3)
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                    ],
                  ),
                ),
                label: "Wish",
              ),
            ],
          );
        }),
      ),
    );
  }
}
