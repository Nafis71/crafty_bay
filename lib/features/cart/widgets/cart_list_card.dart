import 'package:cached_network_image/cached_network_image.dart';
import 'package:crafty_bay/features/cart/view_model/cart_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../common/widgets/small_icon_card.dart';

class CartListCard extends StatelessWidget {
  const CartListCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.fromBorderSide(
              BorderSide(color: Colors.black.withOpacity(0.03))),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 3),
            )
          ]),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: CachedNetworkImage(
              imageUrl:
                  "https://photo.teamrabbil.com/images/2023/04/04/product.png",
              fit: BoxFit.contain,
            ),
          ),
          const Gap(15),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: Text(
                        "New Year Special Shoe",
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                    ),
                    const Expanded(
                      child: Icon(
                        CupertinoIcons.delete_simple,
                        color: Colors.grey,
                        size: 23,
                      ),
                    )
                  ],
                ),
                Text(
                  "Color: Red, Size: X",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 12,
                      ),
                ),
                const Gap(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$100",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 16, color: Theme.of(context).primaryColor),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          onTap: () {},
                          child: const SmallIconCard(
                            icon: Icons.remove,
                            applyPrimaryColor: false,
                          ),
                        ),
                        const Gap(2),
                        GetBuilder<CartViewModel>(
                          builder: (productViewModel) {
                            return Text(
                              "1".toString().padLeft(2, "0"),
                              style: Theme.of(context).textTheme.titleSmall,
                            );
                          },
                        ),
                        const Gap(2),
                        InkWell(
                          splashColor: Colors.transparent,
                          onTap: () {},
                          child: const SmallIconCard(
                            icon: Icons.add,
                            applyPrimaryColor: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
