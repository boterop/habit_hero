import 'package:flutter/material.dart';

class GeneralTheme {
  final int contrast;
  final background;
  final primaryColor;
  final secondaryColor;
  final Brightness brightness;

  GeneralTheme({
    required this.contrast,
    required this.background,
    required this.primaryColor,
    required this.secondaryColor,
    required this.brightness,
  });

  MaterialStateProperty<Color?> _switchColors({bool dark = true}) {
    final color = dark ? primaryColor : primaryColor[contrast];

    return MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) => color,
    );
  }

  _getFloatingTheme() =>
      FloatingActionButtonThemeData(backgroundColor: primaryColor);

  ThemeData getData() => ThemeData(
        primaryColor: background,
        switchTheme: SwitchThemeData(
          thumbColor: _switchColors(),
          trackColor: _switchColors(dark: false),
          trackOutlineColor: _switchColors(),
        ),
        floatingActionButtonTheme: _getFloatingTheme(),
        brightness: brightness,
      );
}
