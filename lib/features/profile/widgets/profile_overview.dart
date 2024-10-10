import 'package:crafty_bay/core/view_model/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/app_assets.dart';
import '../../base_navigation/view_model/base_navigation_view_model.dart';
import '../../cart/view_model/cart_view_model.dart';
import '../../wish_list/view_model/wish_list_view_model.dart';

class ProfileOverview extends StatelessWidget {
  final ProfileViewModel profileViewModel;

  const ProfileOverview({super.key, required this.profileViewModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CircleAvatar(
            radius: 35,
            backgroundColor: Colors.grey.shade100,
            child: Center(
              child: Lottie.asset(
                AppAssets.userPlaceHolderLottie,
                fit: BoxFit.fill,
                width: 65,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profileViewModel.userModel!.cusName.toString(),
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Text(
                profileViewModel.userModel!.user?.email ?? "NA",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.grey),
              ),
              Gap(5),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      navigator!.pop();
                      Get.find<BaseNavigationViewModel>().setIndex = 3;
                    },
                    child: Text(
                      "${Get.find<WishListViewModel>().productWishList.length} Wishlist",
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                          ),
                    ),
                  ),
                  Gap(10),
                  InkWell(
                    onTap: () {
                      navigator!.pop();
                      Get.find<BaseNavigationViewModel>().setIndex = 2;
                    },
                    child: Text(
                      "${Get.find<CartViewModel>().cartList.length} Cart item",
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                          ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
