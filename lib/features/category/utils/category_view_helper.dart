import 'package:crafty_bay/features/category/state_holders/category_view_state.dart';
import 'package:flutter/material.dart';

import '../../../core/services/network_service/internet_service_error.dart';
import '../../../core/services/response/failure.dart';

class CategoryViewHelper {
  static Future<void> getProductByCategory(
      {required CategoryViewState categoryViewState,
      required int categoryId,
      required BuildContext context}) async {
    bool status = await categoryViewState.getProductByCategory(
      categoryId.toString(),
    );
    if (!status && context.mounted) {
      InternetServiceError.showErrorSnackBar(
        failure: categoryViewState.response as Failure,
        context: context,
      );
    }
  }
}
