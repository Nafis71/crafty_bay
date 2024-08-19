import 'package:crafty_bay/common/services/internet_service_error.dart';
import 'package:crafty_bay/common/services/response/failure.dart';
import 'package:crafty_bay/common/widgets/crafty_app_bar.dart';
import 'package:crafty_bay/common/widgets/view_footer.dart';
import 'package:crafty_bay/features/product_review/view_model/product_review_view_model.dart';
import 'package:crafty_bay/features/product_review/widgets/product_review_footer_button.dart';
import 'package:crafty_bay/features/product_review/widgets/product_review_card.dart';
import 'package:crafty_bay/features/product_review/widgets/product_review_footer.dart';
import 'package:crafty_bay/features/product_review/widgets/product_review_footer_text.dart';
import 'package:crafty_bay/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/alternative_widget.dart';
import '../../../../common/widgets/circular_loading.dart';
import '../../../../utils/app_assets.dart';
import '../../../../wrappers/svg_image_loader.dart';

class ProductReviewView extends StatefulWidget {
  final int productId;

  const ProductReviewView({super.key, required this.productId});

  @override
  State<ProductReviewView> createState() => _ProductReviewViewState();
}

class _ProductReviewViewState extends State<ProductReviewView> {
  @override
  void initState() {
    getProductReview();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: craftyAppBar(
        title: AppStrings.productReviewHeader,
        context: context,
      ),
      body: GetBuilder<ProductReviewViewModel>(
        builder: (productReviewViewModel) {
          if (productReviewViewModel.isBusy) {
            return const Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: CircularLoading()),
              ],
            );
          }
          if (productReviewViewModel.response is Failure) {
            return AlternativeWidget(
              onRefresh: getProductReview,
              child: const SvgImageLoader(
                assetLocation: AppAssets.noInternet,
                boxFit: BoxFit.contain,
              ),
            );
          }
          if (productReviewViewModel.productReviewList.isEmpty) {
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
                    AppStrings.noReviewFoundText,
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
                  itemCount: productReviewViewModel.productReviewList.length,
                  itemBuilder: (context, index) {
                    return ProductReviewCard(
                      productReviewData:
                          productReviewViewModel.productReviewList[index],
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
                        "Reviews (${productReviewViewModel.productReviewList.length})",
                  ),
                  rightWidget: FooterButtonWidget(
                    productId:
                        productReviewViewModel.productReviewList[0].productId!,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Future<void> getProductReview() async {
    bool status = await Get.find<ProductReviewViewModel>().getProductReview(
      widget.productId.toString(),
    );
    if (!status && mounted) {
      InternetServiceError.showErrorSnackBar(
        failure: Get.find<ProductReviewViewModel>().response as Failure,
        context: context,
      );
    }
  }
}
