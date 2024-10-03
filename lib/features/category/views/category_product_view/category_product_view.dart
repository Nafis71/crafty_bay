import 'package:crafty_bay/core/services/internet_service_error.dart';
import 'package:crafty_bay/core/services/response/failure.dart';
import 'package:crafty_bay/core/services/response/success.dart';
import 'package:crafty_bay/core/widgets/alternative_widget.dart';
import 'package:crafty_bay/core/widgets/crafty_app_bar.dart';
import 'package:crafty_bay/core/widgets/grid_view_layout.dart';
import 'package:crafty_bay/features/category/view_model/category_view_model.dart';
import 'package:crafty_bay/utils/app_assets.dart';
import 'package:crafty_bay/wrappers/svg_image_loader.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/circular_loading.dart';
import '../../../../core/widgets/product_card.dart';

class CategoryProductView extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  const CategoryProductView(
      {super.key, required this.categoryId, required this.categoryName});

  @override
  State<CategoryProductView> createState() => _CategoryProductViewState();
}

class _CategoryProductViewState extends State<CategoryProductView> {
  @override
  void initState() {
    getProductByCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: craftyAppBar(title: widget.categoryName, context: context),
      body: GetBuilder<CategoryViewModel>(
        builder: (categoryViewModel) {
          if (categoryViewModel.isBusy) {
            return const Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: CircularLoading()),
              ],
            );
          }
          if (categoryViewModel.categoryProductData.isEmpty &&
              categoryViewModel.response is Success) {
            return AlternativeWidget(
              onRefresh: getProductByCategory,
              child: Column(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: Theme.of(context).primaryColor,
                    size: 45,
                  ),
                  const Gap(15),
                  Text(
                    "No product found for ${widget.categoryName.toLowerCase()} category",
                  ),
                ],
              ),
            );
          }
          if (categoryViewModel.response is Failure) {
            return AlternativeWidget(
              onRefresh: getProductByCategory,
              child: const SvgImageLoader(
                assetLocation: AppAssets.noInternet,
                boxFit: BoxFit.contain,
              ),
            );
          }
          return GridViewLayout(
            length: categoryViewModel.categoryProductData.length,
            mainAxisExtent: 200,
            crossAxisExtent: 200,
            child: (index) {
              return ProductCard(
                productList: categoryViewModel.categoryProductData[index],
                isWishListCard: false,
              );
            },
          );
        },
      ),
    );
  }

  Future<void> getProductByCategory() async {
    bool status = await Get.find<CategoryViewModel>().getProductByCategory(
      widget.categoryId.toString(),
    );
    if (!status && mounted) {
      InternetServiceError.showErrorSnackBar(
        failure: Get.find<CategoryViewModel>().response as Failure,
        context: context,
      );
    }
  }
}
