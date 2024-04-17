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

    onToggle(ThemeMode themeMode) {
      widget.setThemeMode(themeMode);
    }

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Switch(
            value: isDarkMode,
            onChanged: (isOn) {
              isOn ? onToggle(ThemeMode.dark) : onToggle(ThemeMode.light);
            },
          ),
        ],
      ),
      body: Text(isDarkMode.toString()),
    );
  }
}
