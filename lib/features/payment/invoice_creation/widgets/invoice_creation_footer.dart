import 'package:crafty_bay/core/utils/app_routes.dart';
import 'package:crafty_bay/core/wrappers/app_snack_bar.dart';
import 'package:crafty_bay/features/payment/invoice_creation/models/payment_method.dart';
import 'package:crafty_bay/features/payment/invoice_creation/utils/invoice_creation_strings.dart';
import 'package:crafty_bay/features/payment/payment_webView/state_holders/payment_webView_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../state_holders/invoice_creation_state.dart';

class InvoiceCreationFooter extends StatelessWidget {
  const InvoiceCreationFooter({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return GetBuilder<InvoiceCreationState>(builder: (invoiceCreationState) {
      return InkWell(
        onTap: () {
          if (invoiceCreationState.isSelectedPaymentIndexEmpty()) {
            AppSnackBar.show(
              message: InvoiceCreationStrings.paymentGatewaySelectionPrompt,
              context: context,
              isError: true,
            );
            return;
          }
          navigateToPaymentWebView(invoiceCreationState);
        },
        child: Container(
          height: 20,
          width: size.width,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          alignment: Alignment.center,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: "Pay \$${invoiceCreationState.totalPayable}",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(fontSize: 18),
                        ),
                        TextSpan(
                          text: " (Vat Included)",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(fontSize: 8),
                        )
                      ]),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: SizedBox(
                        width: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            overlayColor: Colors.transparent,
                            elevation: 0,
                            disabledForegroundColor: Colors.white,
                            disabledBackgroundColor: Colors.transparent,
                          ),
                          onPressed: null,
                          child: Icon(
                            Icons.arrow_circle_right_rounded,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }

  void navigateToPaymentWebView(InvoiceCreationState invoiceCreationState) {
    PaymentMethod paymentMethod = invoiceCreationState.getSelectedPaymentInfo();
    navigator!
        .pushReplacementNamed(AppRoutes.paymentWebView,
            arguments: paymentMethod)
        .then(
      (value) {
        Get.find<PaymentWebViewState>().resetPaymentWebViewState();
      },
    );
  }
}
