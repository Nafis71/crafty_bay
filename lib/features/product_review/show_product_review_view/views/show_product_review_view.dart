import 'package:crafty_bay/core/services/network_service/internet_service_error.dart';
import 'package:crafty_bay/core/services/response/failure.dart';
import 'package:crafty_bay/core/widgets/crafty_app_bar.dart';
import 'package:crafty_bay/core/widgets/shimmer_generator.dart';
import 'package:crafty_bay/core/widgets/view_footer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../core/services/user_auth_service/user_auth_service.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/widgets/alternative_widget.dart';
import '../../../../core/wrappers/svg_image_loader.dart';
import '../../../product_details/utils/product_details_strings.dart';
import '../../add_review_view/views/add_review_view.dart';
import '../../shared/state_holders/product_review_state.dart';
import '../utils/product_review_strings.dart';
import '../widgets/product_review_card.dart';
import '../widgets/product_review_footer_button.dart';
import '../widgets/product_review_footer_text.dart';
import '../widgets/product_review_shimmer.dart';

class ShowProductReviewView extends StatefulWidget {
  final int productId;

  const ShowProductReviewView({super.key, required this.productId});

  @override
  State<ShowProductReviewView> createState() => _ShowProductReviewViewState();
}

class _ShowProductReviewViewState extends State<ShowProductReviewView> {
  @override
  void initState() {
    getProductReview();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: craftyAppBar(
        title: ProductDetailStrings.productReviewHeader,
        context: context,
      ),
      body: GetBuilder<ProductReviewState>(
        builder: (productReviewState) {
          if (productReviewState.isBusy) {
            return ShimmerGenerator(
                shimmer: ProductReviewShimmer(),
                axis: Axis.vertical,
                itemCount: 7,
                shimmerHeight: size.height);
          }
          if (productReviewState.response is Failure) {
            return AlternativeWidget(
              onRefresh: getProductReview,
              child: const SvgImageLoader(
                assetLocation: AppAssets.noInternet,
                boxFit: BoxFit.contain,
              ),
            );
          }
          if (productReviewState.productReviewList.isEmpty) {
            return AlternativeWidget(
              onRefresh: getProductReview,
              child: Column(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: Theme.of(context).primaryColor,
                    size: 45,
                  ),
                  const Gap(15),
                  const Text(
                    ProductReviewStrings.noReviewFoundText,
                  ),
                ],
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                flex: (orientation == Orientation.portrait) ? 7 : 2,
                child: ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  itemCount: productReviewState.productReviewList.length,
                  itemBuilder: (context, index) {
                    return ProductReviewCard(
                      productReviewData:
                          productReviewState.productReviewList[index],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Gap(20);
                  },
                ),
              ),
              Expanded(
                child: ViewFooter(
                  leftWidget: ProductReviewFooterText(
                    text:
                        "Reviews (${productReviewState.productReviewList.length})",
                  ),
                  rightWidget: FooterButtonWidget(
                    productId:
                        productReviewState.productReviewList[0].productId!,
                    navigateToAddProductReview: (productId) {
                      navigateToAddProductReview(productId);
                    },
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  void navigateToAddProductReview(int productId) async {
    bool isAuthenticated =
        await UserAuthService.isUserAuthenticated(futureExecution: (token) {});
    if (!isAuthenticated) {
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddReviewView(
          productId: productId,
        ),
      ),
    );
  }

  Future<void> getProductReview() async {
    bool status = await Get.find<ProductReviewState>().getProductReview(
      widget.productId.toString(),
    );
    if (!status && mounted) {
      InternetServiceError.showErrorSnackBar(
        failure: Get.find<ProductReviewState>().response as Failure,
        context: context,
      );
    }
  }
}
