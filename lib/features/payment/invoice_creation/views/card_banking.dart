import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../models/payment_type_enum.dart';
import '../state_holders/invoice_creation_state.dart';
import '../widgets/payment_methods.dart';

class CardBanking extends StatelessWidget {
  const CardBanking({super.key});

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
                    paymentMethods: invoiceCreationState.paymentMethodsCard,
                    selectedIndex: invoiceCreationState
                        .getSelectedPaymentIndex(PaymentType.card),
                    onTap: (index) {
                      invoiceCreationState.setSelectedPaymentIndex(
                        index,
                        PaymentType.card,
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
