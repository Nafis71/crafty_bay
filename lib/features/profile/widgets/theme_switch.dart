import 'package:flutter/material.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Switch(
      activeColor: Theme.of(context).primaryColor,
      value: false,
      trackOutlineColor: WidgetStateProperty.resolveWith<Color?>(
            (states) {
          return Colors.grey.shade100;
        },
      ),
      trackColor: WidgetStateProperty.resolveWith<Color?>(
            (states) {
          if (states.contains(WidgetState.selected)) {
            return Theme.of(context)
                .primaryColor
                .withOpacity(0.1);
          }
          return Colors.grey.shade100;
        },
      ),
      thumbColor: WidgetStateProperty.resolveWith<Color?>(
            (states) {
          return Theme.of(context).primaryColor;
        },
      ),
      thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
            (states) {
          if (states.contains(WidgetState.selected)) {
            return const Icon(
              Icons.nightlight_round,
              color: Colors.white,
            );
          }
          return const Icon(Icons.wb_sunny_rounded);
        },
      ),
      onChanged: (value) {},
    );
  }
}
