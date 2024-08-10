import 'package:crafty_bay/utils/app_assets.dart';
import 'package:crafty_bay/wrappers/svg_image_loader.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
      body: const Center(
        child: Text("data"),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          useLegacyColorScheme: false,
          backgroundColor: Colors.white,
          elevation: 15,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle:
              const TextStyle(fontSize: 11, fontFamily: "Poppins"),
          unselectedFontSize: 11,
          onTap: (index) {
            if (index == 0) {}
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
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
                label: "Home"),
            const BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 3),
                  child: Column(
                    children: [
                      SvgImageLoader(
                        assetLocation: AppAssets.categoryIcon,
                        boxFit: BoxFit.contain,
                        width: 33,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
                label: "Category"),
            const BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 3),
                  child: Column(
                    children: [
                      SvgImageLoader(
                        assetLocation: AppAssets.cartIcon,
                        boxFit: BoxFit.contain,
                        width: 33,
                        color: Colors.grey,
                      ),
                      Gap(3),
                    ],
                  ),
                ),
                label: "Cart"),
            const BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 3),
                  child: Column(
                    children: [
                      SvgImageLoader(
                        assetLocation: AppAssets.giftIcon,
                        boxFit: BoxFit.contain,
                        width: 33,
                        color: Colors.grey,
                      ),
                      Gap(3),
                    ],
                  ),
                ),
                label: "Wish"),
          ],
        ),
      ),
    );
  }
}
