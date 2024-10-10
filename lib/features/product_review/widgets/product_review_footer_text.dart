import 'package:flutter/material.dart';

class ProductReviewFooterText extends StatelessWidget {
  final String text;

  const ProductReviewFooterText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
