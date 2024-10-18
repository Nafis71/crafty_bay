import 'package:crafty_bay/core/services/internet_service_error.dart';
import 'package:crafty_bay/core/services/response/failure.dart';
import 'package:crafty_bay/core/state_holders/profile_state.dart';
import 'package:crafty_bay/core/utils/app_routes.dart';
import 'package:crafty_bay/core/widgets/circular_loading.dart';
import 'package:crafty_bay/features/payment/invoice_creation/state_holders/invoice_creation_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartFooterButton extends StatelessWidget {
  const CartFooterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvoiceCreationState>(
      builder: (invoiceCreationState) {
        if (invoiceCreationState.isBusy) {
          return Center(
            child: CircularLoading(),
          );
        }
        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.35,
          child: ElevatedButton(
            onPressed: () {
              createInvoice(context, invoiceCreationState);
            },
            child: Text(
              "Checkout",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 13,
                    color: Colors.white,
                  ),
            ),
          ),
        );
      },
    );
  }

  Future<void> createInvoice(
      BuildContext context, InvoiceCreationState invoiceCreationState) async {
    bool status = await invoiceCreationState.createInvoice(
      Get.find<ProfileState>().token,
    );
    if (!status &&
        context.mounted &&
        invoiceCreationState.response is Failure) {
      Failure failure = invoiceCreationState.response as Failure;
      InternetServiceError.showErrorSnackBar(
        failure: failure,
        context: context,
      );
      return;
    }
    navigator!.pushNamed(AppRoutes.invoiceCreationView).then(
      (value) {
        invoiceCreationState.resetPaymentSelection();
      },
    );
  }
}
