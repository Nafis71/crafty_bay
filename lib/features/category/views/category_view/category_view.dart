import 'package:crafty_bay/common/widgets/category_card.dart';
import 'package:crafty_bay/common/widgets/crafty_app_bar.dart';
import 'package:crafty_bay/features/category/view_model/category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryView extends StatefulWidget {
  final bool? fromHome;

  const CategoryView({super.key, this.fromHome});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: craftyAppBar(
          title: "Categories",
          context: (widget.fromHome == null) ? null : context),
      body: GetBuilder<CategoryViewModel>(
        builder: (categoryViewModel) {
          return GridView.builder(
            padding: const EdgeInsets.symmetric(vertical: 15),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 110,
            ),
            itemBuilder: (context, index) {
              return CategoryCard(
                categoryData: categoryViewModel.categoryList[index],
              );
            },
            itemCount: categoryViewModel.categoryList.length,
          );
        },
      ),
    );
  }
}
