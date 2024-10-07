import 'package:flutter/material.dart';

class ProfileOptions extends StatelessWidget {
  final Widget optionTrailingWidget,optionLeadingWidget;
  const ProfileOptions({super.key,required this.optionTrailingWidget, required this.optionLeadingWidget});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shadowColor: Colors.black.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation:0.5,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            optionLeadingWidget,
            optionTrailingWidget,
          ],
        ),
      ),
    );
  }
}
