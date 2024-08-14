import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../themes/app_color.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.searchBarBackgroundColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(
              CupertinoIcons.search,
              color: Colors.grey.shade700,
            ),
            const Gap(4),
            Text(
              "Search",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
