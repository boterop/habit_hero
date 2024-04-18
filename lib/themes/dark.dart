import 'package:flutter/material.dart';

class Dark {
  static const contrast = 100;
  static const background = Colors.black;
  static const primaryColor = Colors.blue;
  static const secondaryColor = Colors.teal;

  static MaterialStateProperty<Color?> _switchColors({bool dark = true}) {
    final primaryColor = dark ? Dark.primaryColor : Dark.primaryColor[contrast];
    final secondaryColor =
        dark ? Dark.secondaryColor[contrast] : Dark.secondaryColor;

    return MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return primaryColor;
        }
        return secondaryColor;
      },
    );
  }

  static const _floatingTheme = FloatingActionButtonThemeData(
    backgroundColor: primaryColor,
  );

  static final theme = ThemeData(
    primaryColor: background,
    switchTheme: SwitchThemeData(
      thumbColor: _switchColors(),
      trackColor: _switchColors(dark: false),
      trackOutlineColor: _switchColors(),
    ),
    floatingActionButtonTheme: _floatingTheme,
    brightness: Brightness.dark,
  );
}
