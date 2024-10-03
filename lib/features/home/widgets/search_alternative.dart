import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/widgets/alternative_widget.dart';

class SearchAlternative extends StatelessWidget {
  final String message;
  final IconData icon;

  const SearchAlternative(
      {super.key, required this.message, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: AlternativeWidget(
        onRefresh: () {},
        child: Column(
          children: [
            Icon(
              icon,
              size: 100,
              color: Colors.grey,
            ),
            const Gap(20),
            Text(message),
          ],
        ),
      ),
    );
  }
}
