import 'package:flutter/material.dart';
import 'package:habit_hero/services/api_service.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late String test = "";

  @override
  void initState() {
    super.initState();
    APIService().health().then((response) => {
          setState(() {
            test = response;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Hero(
          tag: 'addHabit',
          child: Text(test, style: const TextStyle(fontSize: 24)),
        ),
      ),
    );
  }
}
