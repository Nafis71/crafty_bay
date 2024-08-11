import 'package:cached_network_image/cached_network_image.dart';
import 'package:crafty_bay/features/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Flexible(
                child: CachedNetworkImage(
                  imageUrl: Get.find<HomeViewModel>()
                      .categoryList[index]
                      .categoryImg!,
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      width: 80,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    );
                  },
                ),
              ),
              const Gap(3),
              Text(
                Get.find<HomeViewModel>().categoryList[index].categoryName!,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
              )
            ],
          );
        },
        separatorBuilder: (context, index) {
          return const Gap(25);
        },
        itemCount: 4,
      ),
    );
  }
}
