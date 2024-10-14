import 'package:crafty_bay/core/widgets/category_card_shimmer.dart';
import 'package:crafty_bay/core/widgets/crafty_app_bar.dart';
import 'package:crafty_bay/core/widgets/grid_view_layout.dart';
import 'package:crafty_bay/core/widgets/shimmer_generator.dart';
import 'package:crafty_bay/features/category/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../state_holders/category_view_state.dart';

class CategoryView extends StatefulWidget {
  final bool? fromHome;

  const CategoryView({super.key, this.fromHome});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: craftyAppBar(
          title: "Categories",
          context: (widget.fromHome == null) ? null : context),
      body: GetBuilder<CategoryViewState>(
        builder: (categoryViewModel) {
          if (categoryViewModel.categoryList.isEmpty) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  for (int i = 0; i < 10; i++)
                    ShimmerGenerator(
                      shimmer: CategoryCardShimmer(),
                      axis: Axis.horizontal,
                      itemCount: 8,
                      shimmerHeight: 150,
                    ),
                ],
              ),
            );
          }
          return GridViewLayout(
            length: categoryViewModel.categoryList.length,
            mainAxisExtent: 100,
            crossAxisExtent: 110,
            child: (index) {
              return CategoryCard(
                categoryData: categoryViewModel.categoryList[index],
              );
            },
          );
        },
      ),
    );
  }
}
