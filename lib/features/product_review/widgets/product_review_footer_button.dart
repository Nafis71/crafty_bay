import 'package:flutter/material.dart';

import '../views/add_review_view/add_review_view.dart';

class FooterButtonWidget extends StatelessWidget {
  final int productId;

  const FooterButtonWidget({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddReviewView(
                productId: productId,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 5),
                )
              ]),
          alignment: Alignment.center,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
