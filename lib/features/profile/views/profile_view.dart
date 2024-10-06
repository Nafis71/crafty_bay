import 'package:crafty_bay/core/view_model/profile_view_model.dart';
import 'package:crafty_bay/core/widgets/crafty_app_bar.dart';
import 'package:crafty_bay/features/cart/view_model/cart_view_model.dart';
import 'package:crafty_bay/features/wish_list/view_model/wish_list_view_model.dart';
import 'package:crafty_bay/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    checkTokenValidity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: craftyAppBar(title: "Profile", context: context),
      body: GetBuilder<ProfileViewModel>(
        builder: (profileViewModel) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(30),
                Row(
                  children: [
                    Expanded(
                      child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey.shade100,
                          child: Center(
                            child: Lottie.asset(
                              AppAssets.userPlaceHolderLottie,
                              fit: BoxFit.fill,
                              width: 65,
                            ),
                          )),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profileViewModel.userModel.cusName.toString(),
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          Text(
                            profileViewModel.userModel.user!.email.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.grey),
                          ),
                          Gap(5),
                          Row(
                            children: [
                              Text(
                                "${Get.find<WishListViewModel>().productWishList.length} Wishlist",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 14,
                                    ),
                              ),
                              Gap(10),
                              Text(
                                "${Get.find<CartViewModel>().cartList.length} Cart item",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 14),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> checkTokenValidity() async {}
}
