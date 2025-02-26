import 'package:flutter/material.dart';
import 'package:todomaker/style/color.dart';

ButtonStyle get filledWidthButtonStyle => ButtonStyle(
      minimumSize: WidgetStateProperty.all(const Size(double.infinity, 48.0)),
    );

ButtonStyle capsuleTextButtonStyle(BuildContext context) {
  final foregroundColor = Theme.of(context).colorScheme.primary;
  return TextButton.styleFrom(
    foregroundColor: foregroundColor,
    backgroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    shape: const StadiumBorder(),
    elevation: 1,
  );
}

ButtonStyle alertButtonStyle(BuildContext context) {
  final foregroundColor = Theme.of(context).colorScheme.primary;
  return TextButton.styleFrom(
    foregroundColor: foregroundColor,
    disabledForegroundColor: TextColor.disabled(TextColor.gray),
    backgroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    shape: const StadiumBorder(),
    textStyle: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14,
    ),
    elevation: 1,
  );
}
