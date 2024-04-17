import 'package:flutter/material.dart';
import 'package:habit_hero/themes/dark.dart';
import 'package:habit_hero/themes/light.dart';
import 'package:habit_hero/widgets/home.dart';
import 'package:habit_hero/widgets/toggle_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  MainState createState() => MainState();
}

class MainState extends State<MainApp> {
  var themeMode = ThemeMode.system;

  setThemeMode(ThemeMode themeMode) {
    setState(() {
      this.themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Habit Hero",
      themeMode: themeMode,
      theme: Light.theme,
      darkTheme: Dark.theme,
      home: Stack(
        children: [
          const Home(),
          ToggleTheme(setThemeMode: (themeMode) {
            setThemeMode(themeMode);
          }),
        ],
      ),
    );
  }
}
