import 'package:cached_network_image/cached_network_image.dart';
import 'package:crafty_bay/core/utils/product_rating_calculator.dart';
import 'package:crafty_bay/features/home/models/remark_product_model/remark_product_data.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../core/themes/app_color.dart';
import '../../../core/themes/theme_switcher.dart';
import '../../../core/widgets/product_rating.dart';
import '../../product_details/views/product_details_view/product_details_view.dart';

class SearchResult extends StatelessWidget {
  final List<RemarkProductData> matchQuery;

  const SearchResult({super.key, required this.matchQuery});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeSwitcher>(builder: (themeSwitcher) {
      return Container(
        color: themeSwitcher.getComponentColor(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(
                left: 10,
                top: 5,
              ),
              child: Text("Search Results:"),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(10),
                itemCount: matchQuery.length,
                itemBuilder: (context, index) {
                  return Material(
                    color: themeSwitcher.getComponentColor(),
                    child: ListTile(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsView(
                              productId: matchQuery[index].id!,
                            ),
                          ),
                        );
                      },
                      contentPadding: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      tileColor: (themeSwitcher.themeMode == ThemeMode.light)
                          ? Colors.grey.shade100
                          : AppColor.darkComponentsColor,
                      title: Text(
                        matchQuery[index].title!,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: (themeSwitcher.themeMode == ThemeMode.dark)
                                  ? Colors.white
                                  : null,
                              fontFamily: "Poppins",
                            ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(5),
                          Row(
                            children: [
                              Text(
                                "\$${matchQuery[index].price!}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Poppins",
                                    ),
                              ),
                              const Gap(5),
                              ProductRating(
                                productRating:
                                    ProductRatingCalculator().getProductRating(
                                  matchQuery[index].star ?? 0.0,
                                ),
                                iconSize: 20,
                                fontSize: 14,
                              )
                            ],
                          )
                        ],
                      ),
                      leading: CachedNetworkImage(
                        imageUrl: matchQuery[index].image!,
                        width: 90,
                        height: 100,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Gap(5);
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
