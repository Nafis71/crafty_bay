import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class StackedAppBar extends StatelessWidget {
  final String title;
  const StackedAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      left: 20,
      child: Row(
        children: [
          InkWell(
            splashColor: Colors.transparent,
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios,
              weight: 0.2,
            ),
          ),
          const Gap(3),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.black.withOpacity(0.6),
                fontWeight: FontWeight.bold,
                fontSize: 14),
          ),
        ],
      ),
    );
  }
}
