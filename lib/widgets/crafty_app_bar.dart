import 'package:crafty_bay/themes/app_color.dart';
import 'package:crafty_bay/utils/app_assets.dart';
import 'package:crafty_bay/wrappers/svg_image_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

AppBar craftyAppBar({String? title}) {
  return AppBar(
    title: (title == null)
        ? const SvgImageLoader(
            assetLocation: AppAssets.logoNav, boxFit: BoxFit.contain,width: 150,)
        : Text(title),
    centerTitle: false,
    actions: [
      actionItem(CupertinoIcons.person),
      const Gap(10),
      actionItem(CupertinoIcons.phone),
      const Gap(10),
      actionItem(Icons.notifications_active_outlined),
      const Gap(10),
    ],
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
