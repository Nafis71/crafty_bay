import 'package:cached_network_image/cached_network_image.dart';
import 'package:crafty_bay/features/category/models/category_model/category_data.dart';
import 'package:crafty_bay/features/category/views/category_product_view/category_product_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CategoryCard extends StatelessWidget {
  final CategoryData categoryData;

  const CategoryCard({super.key, required this.categoryData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryProductView(
                    categoryId: categoryData.id!,
                    categoryName: categoryData.categoryName!,
                  ),
                ),
              );
            },
            child: CachedNetworkImage(
              imageUrl: categoryData.categoryImg!,
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
        ),
        const Gap(3),
        Text(categoryData.categoryName!,
            style: Theme.of(context).textTheme.bodyMedium)
      ],
    );
  }
}
