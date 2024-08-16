import 'package:crafty_bay/features/product_details/view_models/product_view_model.dart';
import 'package:crafty_bay/features/product_details/widgets/product_image_carousel.dart';
import 'package:crafty_bay/features/product_details/widgets/stacked_app_bar.dart';
import 'package:flutter/material.dart';

class ProductHeader extends StatelessWidget {
  final Orientation deviceOrientation;
  final ProductViewModel productViewModel;
  const ProductHeader({super.key, required this.deviceOrientation, required this.productViewModel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ProductImageCarousel(orientation: deviceOrientation,carouselImageList: productViewModel.carouselImageList,),
        const StackedAppBar(title: "Product Details",)
      ],
    );
  }
}
