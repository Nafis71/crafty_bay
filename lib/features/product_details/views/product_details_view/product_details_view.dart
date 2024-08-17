import 'package:crafty_bay/common/services/internet_service_error.dart';
import 'package:crafty_bay/common/services/response/failure.dart';
import 'package:crafty_bay/common/widgets/alternative_widget.dart';
import 'package:crafty_bay/common/widgets/circular_loading.dart';
import 'package:crafty_bay/common/widgets/crafty_app_bar.dart';
import 'package:crafty_bay/features/product_details/view_models/product_view_model.dart';
import 'package:crafty_bay/features/product_details/widgets/product_body.dart';
import 'package:crafty_bay/features/product_details/widgets/product_description.dart';
import 'package:crafty_bay/features/product_details/widgets/product_footer.dart';
import 'package:crafty_bay/features/product_details/widgets/product_variation.dart';
import 'package:crafty_bay/themes/app_color.dart';
import 'package:crafty_bay/utils/app_assets.dart';
import 'package:crafty_bay/utils/app_strings.dart';
import 'package:crafty_bay/wrappers/svg_image_loader.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../widgets/product_image_carousel.dart';

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

  @override
  Widget build(BuildContext context) {
    Orientation deviceOrientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: craftyAppBar(
          title: AppStrings.productDetailsHeader,
          context: context,
          backgroundColor: AppColor.productCarouselBackgroundColor,
          toolBarHeight: 60),
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
            if (productViewModel.response is Failure) {
              return AlternativeWidget(
                onRefresh: loadProductDetails,
                child: const SvgImageLoader(
                  assetLocation: AppAssets.noInternet,
                  boxFit: BoxFit.contain,
                ),
              );
            }
            if(productViewModel.productData == null){
              return AlternativeWidget(
                onRefresh: loadProductDetails,
                child: Column(
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: Theme.of(context).primaryColor,
                      size: 45,
                    ),
                    const Gap(15),
                    const Text(
                      "No data found for this product",
                    ),
                  ],
                ),
              );
            }
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: (deviceOrientation == Orientation.portrait) ? 7 : 2,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ProductImageCarousel(
                            orientation: deviceOrientation,
                            carouselImageList:
                                productViewModel.carouselImageList,
                          ),
                          const Gap(10),
                          ProductBody(product: productViewModel.productData!),
                          const Gap(10),
                          ProductVariation(
                            productSizes: productViewModel.productSizeList,
                            productColors: productViewModel.productColorList,
                          ),
                          const Gap(20),
                          ProductDescription(
                            description: productViewModel.productData!.shortDes
                                .toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Flexible(
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

  Future<void> loadProductDetails() async {
    bool status =
        await Get.find<ProductViewModel>().getProductDetails(widget.productId);
    if (!status && mounted) {
      InternetServiceError.showErrorSnackBar(
        failure: Get.find<ProductViewModel>().response as Failure,
        context: context,
      );
    }
  }
}
