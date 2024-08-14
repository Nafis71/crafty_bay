import 'package:crafty_bay/features/home/view_model/home_view_model.dart';
import 'package:crafty_bay/features/home/widgets/app_search_bar.dart';
import 'package:crafty_bay/features/home/widgets/carousel_indicator.dart';
import 'package:crafty_bay/features/home/widgets/category_card.dart';
import 'package:crafty_bay/features/home/widgets/product_layout_section.dart';
import 'package:crafty_bay/features/home/widgets/offer_carousel.dart';
import 'package:crafty_bay/features/home/widgets/product_card.dart';
import 'package:crafty_bay/features/home/widgets/section_header.dart';
import 'package:crafty_bay/services/network_urls/network_urls.dart';
import 'package:crafty_bay/themes/app_color.dart';
import 'package:crafty_bay/utils/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../widgets/crafty_app_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeViewModel homeViewModel;

  @override
  void initState() {
    homeViewModel = Get.find<HomeViewModel>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: craftyAppBar(),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppSearchBar(),
              const Gap(5),
              const OfferCarousel(),
              const Gap(8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return CarouselIndicator(
                    index: index,
                  );
                }),
              ),
              const Gap(30),
              if (homeViewModel.categoryList.isNotEmpty)
                const ProductLayoutSection(
                  sectionTitle: AppStrings.homeCategoryHeader,
                  cardWidget: CategoryCard(),
                ),
              const Gap(20),
              if (homeViewModel.popularProductList.isNotEmpty)
                ProductLayoutSection(
                  sectionTitle: AppStrings.homePopularHeader,
                  cardWidget: ProductCard(
                    productList: homeViewModel.popularProductList,
                  ),
                ),
              const Gap(20),
              if (homeViewModel.specialProductList.isNotEmpty)
                ProductLayoutSection(
                  sectionTitle: AppStrings.homeSpecialHeader,
                  cardWidget: ProductCard(
                    productList: homeViewModel.specialProductList,
                  ),
                ),
              const Gap(20),
              if (homeViewModel.newProductList.isNotEmpty)
                ProductLayoutSection(
                  sectionTitle: AppStrings.homeNewHeader,
                  cardWidget: ProductCard(
                    productList: homeViewModel.newProductList,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
