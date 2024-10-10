import 'package:crafty_bay/core/services/user_auth_service/user_auth_service.dart';
import 'package:crafty_bay/themes/theme_switcher.dart';
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
                  child: GetBuilder<ThemeSwitcher>(
                    builder: (themeSwitcher) {
                      return Icon(
                        Icons.arrow_back_ios,
                        weight: 0.4,
                        color: (themeSwitcher.themeMode == ThemeMode.dark)
                            ? Colors.white
                            : Colors.black,
                      );
                    },
                  ),
                ),
              const Gap(5),
              Text(title),
            ],
          ),
    elevation: (title == null) ? 0 : 5,
    centerTitle: false,
    automaticallyImplyLeading: false,
    toolbarHeight: toolBarHeight,
    actions: (title == null)
        ? [
            InkWell(
              onTap: () async {
                if (await Get.find<ProfileViewModel>().isTokenExpired()) {
                  UserAuthService.isUserAuthenticated(
                      futureExecution: (token) {});
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

Widget actionItem(IconData icon) {
  return GetBuilder<ThemeSwitcher>(
    builder: (themeSwitcher) {
      return CircleAvatar(
        backgroundColor: themeSwitcher.getAppBarActionButtonColor(),
        child: Icon(
          icon,
          color: Colors.grey,
        ),
      );
    },
  );
}
