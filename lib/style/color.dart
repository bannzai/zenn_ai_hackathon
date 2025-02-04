import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primary = Color(0xFF4072B3);
  static const Color secondary = Color(0xFF6088C6);
  static const Color tertiary = Color(0xFF80A4D9);
  static const Color accent = Color(0xFFEB8686);
  static const Color background = Color(0xFFFAFAFA);
  static const Color formBackground = Color(0xFFC0C0C0);
  static const Color border = Color(0xFFE0E0E0);
  static const Color disabled = Color(0xFFE0E0E0);

  static const Color sunday = Color(0xFFE17F7F);
  static const Color saturday = Color(0xFF7FB9E1);
  static const Color weekday = Color(0xFF7E7E7E);
}

abstract class TextColor {
  static const Color main = AppColors.primary;
  static const Color darkGray = Color(0xFF404040);
  static const Color gray = Color(0xFF928484);
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color link = Colors.blueAccent;
  static const Color danger = Color(0xFFB00020);
  static const Color discount = Color(0xFFB00020);

  static Color highEmphasis(Color color) => color.withOpacity(0.87);
  static Color mediumEmphasis(Color color) => color.withOpacity(0.6);
  static Color disabled(Color color) => color.withOpacity(0.37);
}
