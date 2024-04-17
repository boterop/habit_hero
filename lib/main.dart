import 'package:flutter/material.dart';
import 'package:habit_hero/themes/dark.dart';
import 'package:habit_hero/themes/light.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Habit Hero",
      themeMode: ThemeMode.system,
      theme: Light.theme,
      darkTheme: Dark.theme,
      home: const Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
