import 'package:crafty_bay/core/widgets/category_card_shimmer.dart';
import 'package:crafty_bay/core/widgets/product_card.dart';
import 'package:crafty_bay/core/widgets/shimmer_generator.dart';
import 'package:crafty_bay/features/home/models/remark_product_model/remark_product_data.dart';
import 'package:crafty_bay/features/home/state_holders/home_view_state.dart';
import 'package:crafty_bay/features/home/utils/home_view_helper.dart';
import 'package:crafty_bay/features/home/utils/home_view_strings.dart';
import 'package:crafty_bay/features/home/widgets/app_search_bar.dart';
import 'package:crafty_bay/features/home/widgets/carousel_indicator.dart';
import 'package:crafty_bay/features/home/widgets/carousel_slider_shimmer.dart';
import 'package:crafty_bay/features/home/widgets/offer_carousel.dart';
import 'package:crafty_bay/features/home/widgets/product_card_shimmer.dart';
import 'package:crafty_bay/features/home/widgets/product_layout_section.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/crafty_app_bar.dart';
import '../../../base_navigation/state_holders/base_navigation_state.dart';
import '../../../category/state_holders/category_view_state.dart';
import '../../../category/widgets/category_card.dart';
import '../all_product_view/all_product_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  void initState() {
    HomeViewHelper.fetchHomeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: craftyAppBar(),
      body: GetBuilder<HomeViewState>(builder: (homeState) {
        return Container(
          margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
          child: ListView(
            children: [
              const AppSearchBar(),
              const Gap(5),
              (homeState.productSliderList.isNotEmpty)
                  ? const OfferCarousel()
                  : ShimmerGenerator(
                      shimmer: CarouselSliderShimmer(),
                      axis: Axis.horizontal,
                      shimmerHeight: 200,
                      itemCount: 1,
                    ),
              const Gap(8),
              if (homeState.productSliderList.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    homeState.productSliderList.length,
                    (index) {
                      return CarouselIndicator(
                        index: index,
                      );
                    },
                  ),
                ),
              const Gap(30),
              (Get.find<CategoryViewState>().categoryList.isNotEmpty)
                  ? ProductLayoutSection(
                      sectionTitle: HomeViewStrings.homeCategoryHeader,
                      cardWidget: SizedBox(
                        height: 100,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return CategoryCard(
                              categoryData: Get.find<CategoryViewState>()
                                  .categoryList[index],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Gap(25);
                          },
                          itemCount:
                              Get.find<CategoryViewState>().categoryList.length,
                        ),
                      ),
                      onTap: () {
                        Get.find<BaseNavigationState>().setIndex = 1;
                      },
                    )
                  : ShimmerGenerator(
                      shimmer: CategoryCardShimmer(),
                      axis: Axis.horizontal,
                      shimmerHeight: 100,
                      itemCount: 6,
                    ),
              const Gap(20),
              (homeState.popularProductList.isNotEmpty)
                  ? ProductLayoutSection(
                      sectionTitle: HomeViewStrings.homePopularHeader,
                      cardWidget: getProductCard(homeState.popularProductList),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AllProductView(
                              elementList: homeState.popularProductList,
                              appBarTitle: HomeViewStrings.homePopularHeader,
                            ),
                          ),
                        );
                      },
                    )
                  : ShimmerGenerator(
                      shimmer: ProductCardShimmer(),
                      axis: Axis.horizontal,
                      itemCount: 6,
                      shimmerHeight: 150,
                    ),
              const Gap(20),
              (homeState.specialProductList.isNotEmpty)
                  ? ProductLayoutSection(
                      sectionTitle: HomeViewStrings.homeSpecialHeader,
                      cardWidget: getProductCard(homeState.specialProductList),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AllProductView(
                              elementList: homeState.specialProductList,
                              appBarTitle: HomeViewStrings.homeSpecialHeader,
                            ),
                          ),
                        );
                      },
                    )
                  : ShimmerGenerator(
                      shimmer: ProductCardShimmer(),
                      axis: Axis.horizontal,
                      itemCount: 6,
                      shimmerHeight: 150,
                    ),
              const Gap(20),
              const Gap(20),
              (homeState.newProductList.isNotEmpty)
                  ? ProductLayoutSection(
                      sectionTitle: HomeViewStrings.homeNewHeader,
                      cardWidget: getProductCard(homeState.newProductList),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AllProductView(
                              elementList: homeState.newProductList,
                              appBarTitle: HomeViewStrings.homeNewHeader,
                            ),
                          ),
                        );
                      },
                    )
                  : ShimmerGenerator(
                      shimmer: ProductCardShimmer(),
                      axis: Axis.horizontal,
                      itemCount: 6,
                      shimmerHeight: 150,
                    ),
            ],
          ),
        );
      }),
    );
  }

  Widget getProductCard(List<RemarkProductData> productList) {
    return SizedBox(
      height: 205,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return ProductCard(
            productList: productList[index],
            isWishListCard: false,
          );
        },
        separatorBuilder: (context, index) {
          return const Gap(20);
        },
        itemCount: productList.length,
      ),
    );
  }
}
