import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:habit_hero/l10n/l10n.dart';
import 'package:habit_hero/screens/sign_in.dart';
import 'package:habit_hero/services/storage_service.dart';
import 'package:habit_hero/services/user_service.dart';
import 'package:habit_hero/themes/dark.dart';
import 'package:habit_hero/themes/light.dart';
import 'package:habit_hero/screens/home.dart';
import 'package:habit_hero/widgets/toggle_theme.dart';
import 'package:habit_hero/widgets/user_button.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  await dotenv.load();
  final String id = await StorageService().load("id") ?? "";
  final String token = await StorageService().load("token") ?? "";
  UserService.instance.updateId(id);
  UserService.instance.updateSession(token);
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  MainState createState() => MainState();
}

class MainState extends State<MainApp> {
  var themeMode = ThemeMode.system;
  @override
  void initState() {
    super.initState();
  }

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
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L10n.locales,
      home: Scaffold(
          appBar: AppBar(
            leading: const UserButton(route: SignIn()),
            actions: <Widget>[ToggleTheme(setThemeMode: setThemeMode)],
          ),
          body: const Home()),
    );
  }
}
