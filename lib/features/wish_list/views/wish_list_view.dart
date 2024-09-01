import 'package:crafty_bay/common/widgets/crafty_app_bar.dart';
import 'package:crafty_bay/common/widgets/grid_view_layout.dart';
import 'package:crafty_bay/features/wish_list/view_model/wish_list_view_model.dart';
import 'package:crafty_bay/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../common/widgets/alternative_widget.dart';
import '../../../common/widgets/circular_loading.dart';
import '../../../common/widgets/product_card.dart';

class WishListView extends StatefulWidget {
  const WishListView({super.key});

  @override
  State<WishListView> createState() => _WishListViewState();
}

class _WishListViewState extends State<WishListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: craftyAppBar(title: AppStrings.wishListViewHeader),
      body: GetBuilder<WishListViewModel>(
        builder: (wishListViewModel) {
          if (wishListViewModel.isBusy) {
            return const Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: CircularLoading()),
              ],
            );
          }
          if (wishListViewModel.productWishList.isEmpty) {
            return AlternativeWidget(
              onRefresh: () {},
              child: Column(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: Theme.of(context).primaryColor,
                    size: 45,
                  ),
                  const Gap(15),
                  const Text(
                    AppStrings.noWishListFoundText,
                  ),
                ],
              ),
            );
          }
          return GridViewLayout(
            length: wishListViewModel.productWishList.length,
            child: (index) {
              return ProductCard(
                productList: wishListViewModel.productWishList[index],
                isWishListCard: true,
              );
            },
          );
        },
      ),
    );
  }
}
