import 'package:cached_network_image/cached_network_image.dart';
import 'package:crafty_bay/core/utils/product_rating_calculator.dart';
import 'package:crafty_bay/core/view_model/profile_view_model.dart';
import 'package:crafty_bay/core/widgets/circular_loading.dart';
import 'package:crafty_bay/core/widgets/product_rating.dart';
import 'package:crafty_bay/core/widgets/small_icon_card.dart';
import 'package:crafty_bay/features/product_details/views/product_details_view/product_details_view.dart';
import 'package:crafty_bay/features/wish_list/view_model/wish_list_view_model.dart';
import 'package:crafty_bay/themes/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProductCard extends StatelessWidget {
  final dynamic productList;
  final bool isWishListCard;

  const ProductCard(
      {super.key, required this.productList, required this.isWishListCard});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsView(productId: productList.id),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: 155,
            height: 195,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  spreadRadius: 1,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.productCardImageBackgroundColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: CachedNetworkImage(
                      imageUrl: productList.image,
                      fit: BoxFit.cover,
                      placeholder: (context, _) {
                        return const CircularLoading();
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          productList.title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontSize: 10,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.bold),
                        ),
                        const Gap(3),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "\$${productList.price}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontSize: 13,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold),
                            ),
                            ProductRating(
                              productRating: ProductRatingCalculator()
                                  .getProductRating(productList.star),
                              iconSize: 18,
                              fontSize: 12,
                            ),
                            GetBuilder<WishListViewModel>(
                              builder: (wishListViewModel) {
                                return InkWell(
                                  onTap: () {
                                    if (wishListViewModel.wishListProductId
                                        .contains(productList.id)) {
                                      return;
                                    }
                                    wishListViewModel.createWishList(
                                      productList.id,
                                      Get.find<ProfileViewModel>().token,
                                    );
                                  },
                                  child: SmallIconCard(
                                    icon: getWishListIcon(wishListViewModel),
                                    applyPrimaryColor: true,
                                    cardInsidePadding: 3.0,
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData getWishListIcon(WishListViewModel wishListViewModel) {
    if (wishListViewModel.wishListProductId.contains(productList.id) &&
        isWishListCard) {
      return CupertinoIcons.delete_simple;
    }
    if (wishListViewModel.wishListProductId.contains(productList.id) &&
        !isWishListCard) {
      return Icons.favorite;
    }
    return Icons.favorite_outline_rounded;
  }
}
