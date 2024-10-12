import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeTheme {
  static PinTheme getPinTheme(BuildContext context) => PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldWidth: 45,
        fieldHeight: 58,
        fieldOuterPadding: const EdgeInsets.symmetric(horizontal: 3),
        activeColor: Theme.of(context).primaryColor,
        selectedColor: Theme.of(context).primaryColor,
        errorBorderColor: Colors.red,
        errorBorderWidth: 1.5,
        selectedBorderWidth: 1.5,
        activeBorderWidth: 1.5,
        inactiveBorderWidth: 1.5,
        inactiveColor: Theme.of(context).primaryColor,
      );
}
