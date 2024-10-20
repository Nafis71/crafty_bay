import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../models/payment_type_enum.dart';
import '../state_holders/invoice_creation_state.dart';
import '../utils/invoice_creation_strings.dart';
import '../widgets/payment_methods.dart';

class InternetBanking extends StatelessWidget {
  const InternetBanking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<InvoiceCreationState>(
        builder: (invoiceCreationState) {
          return Padding(
            padding:
                const EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
            child: Column(
              children: [
                Expanded(
                  child: PaymentMethods(
                    paymentMethods: invoiceCreationState.paymentMethodsInternet,
                    selectedIndex: invoiceCreationState
                        .getSelectedPaymentIndex(PaymentType.internetBanking),
                    onTap: (index) {
                      invoiceCreationState.setSelectedPaymentIndex(
                        index,
                        PaymentType.internetBanking,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
