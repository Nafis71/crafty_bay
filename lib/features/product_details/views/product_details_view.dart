import 'package:crafty_bay/common/widgets/circular_loading.dart';
import 'package:crafty_bay/features/product_details/view_models/product_view_model.dart';
import 'package:crafty_bay/features/product_details/widgets/product_image_carousel.dart';
import 'package:crafty_bay/features/product_details/widgets/stacked_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsView extends StatefulWidget {
  final int productId;

  const ProductDetailsView({super.key, required this.productId});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  @override
  void initState() {
    loadProductDetails();
    super.initState();
  }
  Future<void> loadProductDetails() async{
    await Get.find<ProductViewModel>().getProductDetails(widget.productId);
  }
  @override
  Widget build(BuildContext context) {
    Orientation deviceOrientation = MediaQuery.of(context).orientation;
    return Scaffold(
      body: GetBuilder<ProductViewModel>(
        builder: (productViewModel) {
          if(productViewModel.isBusy){
            return const Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: CircularLoading()),
              ],
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    ProductImageCarousel(orientation: deviceOrientation,carouselImageList: productViewModel.carouselImageList,),
                    const StackedAppBar(title: "Product Details",)
                  ],
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
