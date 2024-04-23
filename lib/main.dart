import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:habit_hero/screens/sign_in.dart';
import 'package:habit_hero/themes/dark.dart';
import 'package:habit_hero/themes/light.dart';
import 'package:habit_hero/screens/home.dart';
import 'package:habit_hero/widgets/toggle_theme.dart';
import 'package:habit_hero/widgets/user_button.dart';

void main() async {
  await dotenv.load();
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
      themeMode: themeMode,
      theme: Light.theme,
      darkTheme: Dark.theme,
      home: Scaffold(
          appBar: AppBar(
            leading: const UserButton(route: SignIn()),
            actions: <Widget>[ToggleTheme(setThemeMode: setThemeMode)],
          ),
          body: const Home()),
    );
  }
}
