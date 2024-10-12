import 'package:crafty_bay/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SectionHeader extends StatelessWidget {
  final String sectionTitle;
  final Function onTap;

  const SectionHeader(
      {super.key, required this.sectionTitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          sectionTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Row(
          children: [
            InkWell(
              splashColor: Colors.transparent,
              onTap: () => onTap(),
              child: Text(
                AppStrings.homeSeeAllButtonText,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: 15,
                    ),
              ),
            ),
            const Gap(5)
          ],
        ),
      ],
    );
  }
}
