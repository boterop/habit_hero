import 'package:flutter/material.dart';
import 'package:habit_hero/themes/general_theme.dart';

class Light {
  static const contrast = 100;
  static const background = Colors.white;
  static const primaryColor = Colors.teal;
  static const secondaryColor = Colors.cyan;
  static const brightness = Brightness.light;

  static final theme = GeneralTheme(
    contrast: contrast,
    background: background,
    primaryColor: primaryColor,
    secondaryColor: secondaryColor,
    brightness: brightness,
  ).getData();
}
