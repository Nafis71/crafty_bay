import 'package:cached_network_image/cached_network_image.dart';
import 'package:crafty_bay/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:gap/gap.dart';

class ProductImageCarousel extends StatelessWidget {
  final Orientation orientation;
  final List<String> carouselImageList;
  const ProductImageCarousel({super.key, required this.orientation, required this.carouselImageList});

  @override
  Widget build(BuildContext context) {
    return FlutterCarousel.builder(
      itemCount: carouselImageList.length,
      itemBuilder: (context, index, pageIndex) {
        return Container(
          decoration: BoxDecoration(
            color: AppColor.productCarouselBackgroundColor,
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Gap(30),
              CachedNetworkImage(
                imageUrl:
                    carouselImageList[index],
                fit: BoxFit.contain,
              ),
            ],
          ),
        );
      },
      options: CarouselOptions(
        viewportFraction: 1,
        aspectRatio: (orientation == Orientation.portrait) ? 1.3 : 1.8,
        initialPage: 0,
        indicatorMargin: 25,
        slideIndicator: CircularSlideIndicator(
          slideIndicatorOptions: SlideIndicatorOptions(
            currentIndicatorColor: Theme.of(context).primaryColor,
            indicatorRadius: 8,
            itemSpacing: 23,
            indicatorBackgroundColor: Colors.white,
            enableAnimation: true
          ),
        ),
      ),
    );
  }
}
