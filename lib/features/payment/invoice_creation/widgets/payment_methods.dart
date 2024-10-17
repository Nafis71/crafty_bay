import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/grid_view_layout.dart';
import '../models/payment_method.dart';

class PaymentMethods extends StatelessWidget {
  final List<PaymentMethod> paymentMethods;

  const PaymentMethods({super.key, required this.paymentMethods});

  @override
  Widget build(BuildContext context) {
    return GridViewLayout(
      length: paymentMethods.length,
      child: (index) {
        return CachedNetworkImage(
          imageUrl: paymentMethods[index].logo.toString().toString(),
          errorWidget: (context, string, _) {
            return Icon(
              Icons.error,
              color: Colors.red,
            );
          },
          imageBuilder: (context, imageProvider) {
            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fill,
                  ),
                  border: Border.fromBorderSide(BorderSide(color: Colors.grey.shade200))
              ),
            );
          },
        );
      },
      mainAxisExtent: 60,
      crossAxisExtent: 60,
    );
  }
}
