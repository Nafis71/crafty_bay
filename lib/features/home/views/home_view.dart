import 'package:crafty_bay/features/home/widgets/app_search_bar.dart';
import 'package:crafty_bay/features/home/widgets/carousel_indicator.dart';
import 'package:crafty_bay/features/home/widgets/category_card.dart';
import 'package:crafty_bay/features/home/widgets/offer_carousel.dart';
import 'package:crafty_bay/features/home/widgets/section_header.dart';
import 'package:crafty_bay/themes/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:gap/gap.dart';

import '../../../widgets/crafty_app_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: craftyAppBar(),
      body: Container(
        margin: const EdgeInsets.all(8),
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
              SectionHeader(sectionTitle: "All Categories", onTap: () {}),
              const Gap(10),
              const CategoryCard(),
            ],
          ),
        ),
      ),
    );
  }
}
