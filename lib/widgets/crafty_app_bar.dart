import 'package:crafty_bay/themes/app_color.dart';
import 'package:crafty_bay/utils/app_assets.dart';
import 'package:crafty_bay/wrappers/svg_image_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

AppBar craftyAppBar({String? title, BuildContext? context}) {
  return AppBar(
    title: (title == null)
        ? const SvgImageLoader(
            assetLocation: AppAssets.logoNav,
            boxFit: BoxFit.contain,
            width: 150,
          )
        : Row(
            children: [
              InkWell(
                splashColor: Colors.transparent,
                onTap: () => Navigator.pop(context!),
                child: const Icon(
                  Icons.arrow_back_ios,
                  weight: 0.4,
                ),
              ),
              const Gap(5),
              Text(title),
            ],
          ),
    elevation: (title == null) ? 0 : 5,
    centerTitle: false,
    automaticallyImplyLeading: false,
    actions: (title == null)
        ? [
            actionItem(CupertinoIcons.person),
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
