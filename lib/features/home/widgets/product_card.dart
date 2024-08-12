import 'package:cached_network_image/cached_network_image.dart';
import 'package:crafty_bay/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Column(
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
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: AppColor.appSecondaryColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: CachedNetworkImage(
                            imageUrl:
                                "https://photo.teamrabbil.com/images/2023/04/04/product.png"),
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
                              "New Year Special Shoe 30",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontSize: 10, color: Colors.grey.shade600,fontWeight: FontWeight.bold),
                            ),
                            const Gap(3),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "\$100",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontSize: 13, color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
                                ),
                                 Row(
                                   children: [
                                     Icon(Icons.star,size: 18,color: AppColor.ratingIconColor,),
                                     Text(
                                       "4.8",
                                       style: Theme.of(context)
                                           .textTheme
                                           .bodyMedium!
                                           .copyWith(fontSize: 12, color: Colors.grey.shade600,),
                                     ),
                                   ],
                                 ),
                                Card(
                                  color: Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3)
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: Icon(Icons.favorite_outline_rounded,color: Colors.white,size: 15,),
                                  ),
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
          );
        },
        separatorBuilder: (context, index) {
          return const Gap(20);
        },
        itemCount: 3,
      ),
    );
  }
}
