import 'package:crafty_bay/core/services/network_service/internet_service_error.dart';
import 'package:crafty_bay/core/services/response/failure.dart';
import 'package:crafty_bay/core/utils/form_validation.dart';
import 'package:crafty_bay/core/widgets/crafty_app_bar.dart';
import 'package:crafty_bay/features/product_review/add_review_view/utils/add_review_view_strings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../profile/shared/state_holders/profile_state.dart';
import '../../../../../core/widgets/circular_loading.dart';
import '../../../../../core/wrappers/app_snack_bar.dart';
import '../../shared/state_holders/product_review_state.dart';
import '../../shared/widgets/product_review_rating_bar.dart';

class AddReviewView extends StatefulWidget {
  final int productId;

  const AddReviewView({super.key, required this.productId});

  @override
  State<AddReviewView> createState() => _AddReviewViewState();
}

class _AddReviewViewState extends State<AddReviewView> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _reviewTEController;

  @override
  void initState() {
    _reviewTEController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: craftyAppBar(
          title: AddReviewViewStrings.addReviewHeader, context: context),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 25, right: 25, top: 40, bottom: 10),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _reviewTEController,
                      maxLines: 10,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        hintText: AddReviewViewStrings.writeReviewHintText,
                      ),
                      validator: FormValidation.validateReview,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const Gap(20),
                    Text(AddReviewViewStrings.ratingBarHeaderText),
                    const Gap(10),
                    ProductReviewRatingBar.show(initialRating: 3),
                    const Gap(30),
                    GetBuilder<ProductReviewState>(
                        builder: (productReviewViewModel) {
                      if (productReviewViewModel.isCreatingReview) {
                        return const Center(
                          child: CircularLoading(),
                        );
                      }
                      return ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            createReview(productReviewViewModel);
                          }
                        },
                        child: Text(
                          AddReviewViewStrings.reviewSubmitButtonText,
                        ),
                      );
                    })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createReview(ProductReviewState productReviewState) async {
    bool status = await productReviewState.createProductReview(
      productId: widget.productId,
      token: Get.find<ProfileState>().token,
      review: _reviewTEController.text.trim(),
    );
    if (status && mounted) {
      AppSnackBar.show(
        message: AddReviewViewStrings.reviewCreationSuccessMessage,
        context: context,
        isError: false,
      );
      Navigator.pop(context);
      return;
    }
    Failure failure = productReviewState.response as Failure;
    if ((failure.statusCode != 600 ||
            failure.statusCode != 601 ||
            failure.statusCode != 500) &&
        mounted) {
      AppSnackBar.show(
        message: AddReviewViewStrings.reviewCreationFailedMessage,
        context: context,
        isError: true,
      );
      return;
    }
    if (mounted) {
      InternetServiceError.showErrorSnackBar(
        failure: failure,
        context: context,
      );
    }
  }

  @override
  void dispose() {
    _reviewTEController.dispose();
    super.dispose();
  }
}
