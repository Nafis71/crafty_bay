import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../core/state_holders/profile_state.dart';
import '../../../core/utils/app_assets.dart';
import '../../base_navigation/state_holders/base_navigation_state.dart';
import '../../cart/state_holders/cart_view_state.dart';
import '../../wish_list/state_holders/wish_list_state.dart';

class ProfileOverview extends StatelessWidget {
  final ProfileState profileState;

  const ProfileOverview({super.key, required this.profileState});

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
                profileState.userModel!.cusName.toString(),
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Text(
                profileState.userModel!.user?.email ?? "NA",
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
                      Get.find<BaseNavigationState>().setIndex = 3;
                    },
                    child: Text(
                      "${Get.find<WishListState>().productWishList.length} Wishlist",
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
                      Get.find<BaseNavigationState>().setIndex = 2;
                    },
                    child: Text(
                      "${Get.find<CartViewState>().cartList.length} Cart item",
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
