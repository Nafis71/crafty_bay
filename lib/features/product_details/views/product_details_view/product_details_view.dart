import 'dart:async';

import 'package:crafty_bay/core/services/internet_service_error.dart';
import 'package:crafty_bay/core/services/response/failure.dart';
import 'package:crafty_bay/core/services/user_auth_service/user_auth_service.dart';
import 'package:crafty_bay/core/utils/app_assets.dart';
import 'package:crafty_bay/core/utils/app_strings.dart';
import 'package:crafty_bay/core/widgets/alternative_widget.dart';
import 'package:crafty_bay/core/widgets/crafty_app_bar.dart';
import 'package:crafty_bay/core/widgets/shimmer_generator.dart';
import 'package:crafty_bay/core/widgets/view_footer.dart';
import 'package:crafty_bay/features/product_details/widgets/product_body.dart';
import 'package:crafty_bay/features/product_details/widgets/product_description.dart';
import 'package:crafty_bay/features/product_details/widgets/product_details_footer_button.dart';
import 'package:crafty_bay/features/product_details/widgets/product_details_footer_text.dart';
import 'package:crafty_bay/features/product_details/widgets/product_details_shimmer.dart';
import 'package:crafty_bay/features/product_details/widgets/product_variation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../core/state_holders/profile_state.dart';
import '../../../../core/wrappers/svg_image_loader.dart';
import '../../../cart/state_holders/cart_view_state.dart';
import '../../state_holders/product_state.dart';
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
    Size size = MediaQuery.sizeOf(context);
    print(widget.productId);
    return Scaffold(
      appBar: craftyAppBar(
        title: AppStrings.productDetailsHeader,
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
                onRefresh: loadProductDetails,
                child: const SvgImageLoader(
                  assetLocation: AppAssets.noInternet,
                  boxFit: BoxFit.contain,
                ),
              );
            }
            if (productState.productData == null) {
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
                      AppStrings.noProductFoundText,
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
                        addToCart: (cartViewState) => addToCart(cartViewState),
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

  Future<void> addToCart(CartViewState cartViewModel) async {
    bool isAuthenticated =
        await UserAuthService.isUserAuthenticated(futureExecution: (token) {
      addToCart(cartViewModel);
    });
    if (!isAuthenticated) {
      return;
    }
    bool status = await cartViewModel.createCartList(
      productId: widget.productId,
      token: Get.find<ProfileState>().token,
    );
    if (!status && mounted) {
      Failure failure = cartViewModel.response as Failure;
      InternetServiceError.showErrorSnackBar(
        failure: failure,
        context: context,
      );
      return;
    }
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timer.tick == 3) {
        Get.find<ProductState>().setIsItemAddedToCart = false;
      }
    });
  }

  Future<void> loadProductDetails() async {
    bool status =
        await Get.find<ProductState>().getProductDetails(widget.productId);
    if (!status && mounted && Get.find<ProductState>().response is Failure) {
      InternetServiceError.showErrorSnackBar(
        failure: Get.find<ProductState>().response as Failure,
        context: context,
      );
    }
  }
}
