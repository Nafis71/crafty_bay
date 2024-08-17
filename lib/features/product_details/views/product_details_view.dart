import 'package:crafty_bay/common/widgets/circular_loading.dart';
import 'package:crafty_bay/common/widgets/crafty_app_bar.dart';
import 'package:crafty_bay/features/product_details/view_models/product_view_model.dart';
import 'package:crafty_bay/features/product_details/widgets/product_body.dart';
import 'package:crafty_bay/features/product_details/widgets/product_description.dart';
import 'package:crafty_bay/features/product_details/widgets/product_footer.dart';
import 'package:crafty_bay/features/product_details/widgets/product_variation.dart';
import 'package:crafty_bay/themes/app_color.dart';
import 'package:crafty_bay/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../widgets/product_image_carousel.dart';

class ProductDetailsView extends StatefulWidget {
  final int productId;

  const ProductDetailsView({super.key, required this.productId});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  @override
  void initState() {
    loadProductDetails();
    super.initState();
  }

  Future<void> loadProductDetails() async {
    await Get.find<ProductViewModel>().getProductDetails(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    Orientation deviceOrientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: craftyAppBar(
        title: AppStrings.productDetailsHeader,
        context: context,
        backgroundColor: AppColor.productCarouselBackgroundColor,
        toolBarHeight: 60
      ),
      body: SafeArea(
        child: GetBuilder<ProductViewModel>(
          builder: (productViewModel) {
            if (productViewModel.isBusy) {
              return const Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: CircularLoading()),
                ],
              );
            }
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 7,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ProductImageCarousel(orientation: deviceOrientation,carouselImageList: productViewModel.carouselImageList,),
                          const Gap(10),
                          ProductBody(product: productViewModel.productData!),
                          const Gap(10),
                          ProductVariation(
                            productSizes: productViewModel.productSizeList,
                            productColors: productViewModel.productColorList,
                          ),
                          const Gap(20),
                          ProductDescription(
                            description:
                                productViewModel.productData!.shortDes.toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: ProductFooter(),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
