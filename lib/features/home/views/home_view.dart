import 'package:crafty_bay/features/home/view_model/home_view_model.dart';
import 'package:crafty_bay/features/home/views/all_product_view.dart';
import 'package:crafty_bay/features/home/widgets/app_search_bar.dart';
import 'package:crafty_bay/features/home/widgets/carousel_indicator.dart';
import 'package:crafty_bay/features/home/widgets/category_card.dart';
import 'package:crafty_bay/features/home/widgets/offer_carousel.dart';
import 'package:crafty_bay/features/home/widgets/product_card.dart';
import 'package:crafty_bay/features/home/widgets/product_layout_section.dart';
import 'package:crafty_bay/utils/app_routes.dart';
import 'package:crafty_bay/utils/app_strings.dart';
import 'package:flutter/material.dart';
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
                ProductLayoutSection(
                  sectionTitle: AppStrings.homeCategoryHeader,
                  cardWidget: const CategoryCard(),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AllProductView(
                                elementList: homeViewModel.categoryList)));
                  },
                ),
              const Gap(20),
              if (homeViewModel.popularProductList.isNotEmpty)
                ProductLayoutSection(
                  sectionTitle: AppStrings.homePopularHeader,
                  cardWidget: ProductCard(
                    productList: homeViewModel.popularProductList,
                  ),
                  onTap: () {},
                ),
              const Gap(20),
              if (homeViewModel.specialProductList.isNotEmpty)
                ProductLayoutSection(
                  sectionTitle: AppStrings.homeSpecialHeader,
                  cardWidget: ProductCard(
                    productList: homeViewModel.specialProductList,
                  ),
                  onTap: () {},
                ),
              const Gap(20),
              if (homeViewModel.newProductList.isNotEmpty)
                ProductLayoutSection(
                  sectionTitle: AppStrings.homeNewHeader,
                  cardWidget: ProductCard(
                    productList: homeViewModel.newProductList,
                  ),
                  onTap: () {},
                ),
            ],
          ),
        ),
      ),
    );
  }
}
