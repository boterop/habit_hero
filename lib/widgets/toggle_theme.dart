import 'package:flutter/material.dart';

class ToggleTheme extends StatefulWidget {
  final Function setThemeMode;
  const ToggleTheme({super.key, required this.setThemeMode});

  @override
  // ignore: library_private_types_in_public_api
  _ToggleState createState() => _ToggleState();
}

class _ToggleState extends State<ToggleTheme> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final thumbIconDark = MaterialStateProperty.resolveWith<Icon?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return const Icon(Icons.brightness_5);
        }
        return const Icon(Icons.brightness_2);
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
