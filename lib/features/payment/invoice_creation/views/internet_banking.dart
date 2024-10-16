import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../state_holders/invoice_creation_state.dart';
import '../widgets/payment_methods.dart';

class InternetBanking extends StatelessWidget {
  const InternetBanking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<InvoiceCreationState>(
        builder: (invoiceCreationState) {
          return PaymentMethods(
            paymentMethods: invoiceCreationState.paymentMethodsInternet,
          );
        },
      ),
    );
  }
}
