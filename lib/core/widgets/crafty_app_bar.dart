import 'package:crafty_bay/features/cart/view_model/cart_view_model.dart';
import 'package:crafty_bay/themes/app_color.dart';
import 'package:crafty_bay/utils/app_assets.dart';
import 'package:crafty_bay/utils/app_routes.dart';
import 'package:crafty_bay/wrappers/svg_image_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../view_model/profile_view_model.dart';

AppBar craftyAppBar({
  String? title,
  BuildContext? context,
  Color? backgroundColor,
  double? toolBarHeight,
}) {
  return AppBar(
    title: (title == null)
        ? const SvgImageLoader(
            assetLocation: AppAssets.logoNav,
            boxFit: BoxFit.contain,
            width: 140,
          )
        : Row(
            children: [
              if (context != null)
                InkWell(
                  splashColor: Colors.transparent,
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    weight: 0.4,
                  ),
                ),
              const Gap(5),
              Text(title),
            ],
          ),
    backgroundColor: (backgroundColor != null) ? backgroundColor : null,
    surfaceTintColor: (backgroundColor != null) ? backgroundColor : null,
    elevation: (title == null || backgroundColor != null) ? 0 : 5,
    centerTitle: false,
    automaticallyImplyLeading: false,
    toolbarHeight: toolBarHeight,
    actions: (title == null)
        ? [
            InkWell(
              onTap: () async {
                if (await Get.find<ProfileViewModel>().isTokenExpired()) {
                  navigator!.pushNamed(
                    AppRoutes.loginView,
                    arguments: (token) async {
                      Get.find<CartViewModel>().getCartList(token);
                    },
                  );
                  return;
                }
                navigator?.pushNamed(AppRoutes.profileView);
              },
              child: actionItem(CupertinoIcons.person),
            ),
            const Gap(10),
            actionItem(CupertinoIcons.phone),
            const Gap(10),
            actionItem(Icons.notifications_active_outlined),
            const Gap(10),
          ]
        : null,
  );
}

CircleAvatar actionItem(IconData icon) {
  return CircleAvatar(
    backgroundColor: AppColor.appBarActionButtonColor,
    child: Icon(
      icon,
      color: Colors.grey,
    ),
  );
}
