import 'package:crafty_bay/core/services/response/failure.dart';
import 'package:crafty_bay/core/utils/app_assets.dart';
import 'package:crafty_bay/core/widgets/alternative_widget.dart';
import 'package:crafty_bay/core/widgets/crafty_app_bar.dart';
import 'package:crafty_bay/core/widgets/shimmer_generator.dart';
import 'package:crafty_bay/core/widgets/view_footer.dart';
import 'package:crafty_bay/features/product_details/utils/product_details_strings.dart';
import 'package:crafty_bay/features/product_details/utils/product_details_view_helper.dart';
import 'package:crafty_bay/features/product_details/widgets/product_body.dart';
import 'package:crafty_bay/features/product_details/widgets/product_description.dart';
import 'package:crafty_bay/features/product_details/widgets/product_details_footer_button.dart';
import 'package:crafty_bay/features/product_details/widgets/product_details_footer_text.dart';
import 'package:crafty_bay/features/product_details/widgets/product_details_shimmer.dart';
import 'package:crafty_bay/features/product_details/widgets/product_variation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../core/wrappers/svg_image_loader.dart';
import '../state_holders/product_state.dart';
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
    ProductDetailsViewHelper.loadProductDetails(
      productState: Get.find<ProductState>(),
      context: context,
      productId: widget.productId,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Orientation deviceOrientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: craftyAppBar(
        title: ProductDetailStrings.productDetailsHeader,
        context: context,
      ),
      body: SafeArea(
        child: GetBuilder<ProductState>(
          builder: (productState) {
            if (productState.isBusy) {
              return ShimmerGenerator(
                shimmer: ProductDetailsShimmer(),
                axis: Axis.vertical,
                itemCount: 2,
                shimmerHeight: size.height,
              );
            }
            if (productState.response is Failure) {
              return AlternativeWidget(
                onRefresh: () {
                  ProductDetailsViewHelper.loadProductDetails(
                    productState: productState,
                    context: context,
                    productId: widget.productId,
                  );
                },
                child: const SvgImageLoader(
                  assetLocation: AppAssets.noInternet,
                  boxFit: BoxFit.contain,
                ),
              );
            }
            if (productState.productData == null) {
              return AlternativeWidget(
                onRefresh: () {
                  ProductDetailsViewHelper.loadProductDetails(
                    productState: productState,
                    context: context,
                    productId: widget.productId,
                  );
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: Theme.of(context).primaryColor,
                      size: 45,
                    ),
                    const Gap(15),
                    const Text(
                      ProductDetailStrings.noProductFoundText,
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
                            carouselImageList: productState.carouselImageList,
                          ),
                          const Gap(10),
                          ProductBody(product: productState.productData!),
                          const Gap(10),
                          ProductVariation(
                            productSizes: productState.productSizeList,
                            productColors: productState.productColorList,
                          ),
                          const Gap(20),
                          ProductDescription(
                            description: productState.productData!.description
                                .toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: ViewFooter(
                      leftWidget: const ProductDetailsFooterText(),
                      rightWidget: ProductDetailsFooterButton(
                        addToCart: (cartViewState) {
                          ProductDetailsViewHelper.addToCart(
                            cartViewState: cartViewState,
                            productState: productState,
                            productId: widget.productId,
                            context: context,
                          );
                        },
                      ),
                    ),
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
