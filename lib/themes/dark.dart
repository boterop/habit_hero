import 'package:flutter/material.dart';
import 'package:habit_hero/themes/general_theme.dart';

class Dark {
  static const contrast = 100;
  static const background = Colors.black;
  static const primaryColor = Colors.blue;
  static const secondaryColor = Colors.teal;
  static const brightness = Brightness.dark;

  static final theme = GeneralTheme(
    contrast: contrast,
    background: background,
    primaryColor: primaryColor,
    secondaryColor: secondaryColor,
    brightness: brightness,
  ).getData();
}
