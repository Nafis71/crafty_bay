import 'package:crafty_bay/features/home/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProductLayoutSection extends StatelessWidget {
  final String sectionTitle;
  final Widget cardWidget;
  final Function onTap;

  const ProductLayoutSection(
      {super.key,
      required this.sectionTitle,
      required this.cardWidget,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(sectionTitle: sectionTitle, onTap: () => onTap()),
        const Gap(15),
        cardWidget,
      ],
    );
  }
}
