import 'package:flutter/material.dart';

class ToggleTheme extends StatefulWidget {
  final Function setThemeMode;
  const ToggleTheme({super.key, required this.setThemeMode});

  @override
  State<ToggleTheme> createState() => _ToggleState();
}

class _ToggleState extends State<ToggleTheme> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final thumbIconDark = MaterialStateProperty.resolveWith<Icon?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return const Icon(
            Icons.brightness_5,
            color: Colors.white,
          );
        }
        return const Icon(Icons.brightness_2, color: Colors.black);
      },
    );

    onToggle(ThemeMode themeMode) {
      widget.setThemeMode(themeMode);
    }

    return Switch(
      value: isDarkMode,
      thumbIcon: thumbIconDark,
      onChanged: (isOn) {
        isOn ? onToggle(ThemeMode.dark) : onToggle(ThemeMode.light);
      },
    );
  }
}
