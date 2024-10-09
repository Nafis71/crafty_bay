import 'package:crafty_bay/core/services/prefetch_service.dart';
import 'package:crafty_bay/core/widgets/category_card_shimmer.dart';
import 'package:crafty_bay/core/widgets/product_card.dart';
import 'package:crafty_bay/core/widgets/shimmer_generator.dart';
import 'package:crafty_bay/features/base_navigation/view_model/base_navigation_view_model.dart';
import 'package:crafty_bay/features/category/view_model/category_view_model.dart';
import 'package:crafty_bay/features/home/models/remark_product_model/remark_product_data.dart';
import 'package:crafty_bay/features/home/view_model/home_view_model.dart';
import 'package:crafty_bay/features/home/views/all_product_view/all_product_view.dart';
import 'package:crafty_bay/features/home/widgets/app_search_bar.dart';
import 'package:crafty_bay/features/home/widgets/carousel_indicator.dart';
import 'package:crafty_bay/features/home/widgets/carousel_slider_shimmer.dart';
import 'package:crafty_bay/features/home/widgets/offer_carousel.dart';
import 'package:crafty_bay/features/home/widgets/product_card_shimmer.dart';
import 'package:crafty_bay/features/home/widgets/product_layout_section.dart';
import 'package:crafty_bay/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/crafty_app_bar.dart';
import '../../../category/widgets/category_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeViewModel homeViewModel;

  @override
  void initState() {
    fetchHomeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: craftyAppBar(),
      body: GetBuilder<HomeViewModel>(builder: (homeViewModel) {
        return Container(
          margin: const EdgeInsets.only(left: 8, right: 8),
          child: ListView(
            children: [
              const AppSearchBar(),
              const Gap(5),
              (homeViewModel.productSliderList.isNotEmpty)
                  ? const OfferCarousel()
                  : ShimmerGenerator(
                      shimmer: CarouselSliderShimmer(),
                      axis: Axis.horizontal,
                      shimmerHeight: 200,
                      itemCount: 1,
                    ),
              const Gap(8),
              if (homeViewModel.productSliderList.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    homeViewModel.productSliderList.length,
                    (index) {
                      return CarouselIndicator(
                        index: index,
                      );
                    },
                  ),
                ),
              const Gap(30),
              (Get.find<CategoryViewModel>().categoryList.isNotEmpty)
                  ? ProductLayoutSection(
                      sectionTitle: AppStrings.homeCategoryHeader,
                      cardWidget: SizedBox(
                        height: 100,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return CategoryCard(
                                categoryData: Get.find<CategoryViewModel>()
                                    .categoryList[index]);
                          },
                          separatorBuilder: (context, index) {
                            return const Gap(25);
                          },
                          itemCount: Get.find<CategoryViewModel>().categoryList.length,
                        ),
                      ),
                      onTap: () {
                        Get.find<BaseNavigationViewModel>().setIndex = 1;
                      },
                    )
                  : ShimmerGenerator(
                      shimmer: CategoryCardShimmer(),
                      axis: Axis.horizontal,
                      shimmerHeight: 100,
                      itemCount: 6,
                    ),
              const Gap(20),
              (homeViewModel.popularProductList.isNotEmpty)
                  ? ProductLayoutSection(
                      sectionTitle: AppStrings.homePopularHeader,
                      cardWidget:
                          getProductCard(homeViewModel.popularProductList),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AllProductView(
                              elementList: homeViewModel.popularProductList,
                              appBarTitle: AppStrings.homePopularHeader,
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
              (homeViewModel.specialProductList.isNotEmpty)
                  ? ProductLayoutSection(
                      sectionTitle: AppStrings.homeSpecialHeader,
                      cardWidget:
                          getProductCard(homeViewModel.specialProductList),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AllProductView(
                              elementList: homeViewModel.specialProductList,
                              appBarTitle: AppStrings.homeSpecialHeader,
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
              (homeViewModel.newProductList.isNotEmpty)
                  ? ProductLayoutSection(
                      sectionTitle: AppStrings.homeNewHeader,
                      cardWidget: getProductCard(homeViewModel.newProductList),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AllProductView(
                              elementList: homeViewModel.newProductList,
                              appBarTitle: AppStrings.homeNewHeader,
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

  Future<void> fetchHomeData() async {
    List<bool> responses = await PrefetchService.fetchHomeData();
    if(responses.contains(false)){
      fetchHomeData();
    }else{
      Get.find<HomeViewModel>().update();
    }
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
