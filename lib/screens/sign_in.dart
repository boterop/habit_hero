import 'package:flutter/material.dart';
import 'package:habit_hero/services/api_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:habit_hero/services/storage_service.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  void initState() {
    super.initState();
    APIService()
        .health()
        .then((response) => {if (!response) Navigator.pop(context)})
        .catchError((error) => {Navigator.pop(context)});
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    validateUser(
      TextEditingController emailController,
      TextEditingController passwordController,
    ) {
      String email = emailController.text;
      String password = passwordController.text;
      APIService().signIn(email: email, password: password).then((response) {
        switch (response) {
          case {"errors": "Unauthorized"}:
            passwordController.clear();
            formKey.currentState!.validate();
            break;
          case {"data": _}:
            String token = response["data"]["token"];
            StorageService.save(key: "token", content: token);
            Navigator.pop(context);
            break;
        }
      });
    }

    return Scaffold(
        appBar: AppBar(),
        body: Center(
            child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: '${AppLocalizations.of(context)!.email}:',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.enterValidEmail;
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: '${AppLocalizations.of(context)!.password}:',
                ),
                obscureText: true,
                validator: (String? value) {
                  String email = emailController.text;
                  if (email.isNotEmpty && (value == null || value.isEmpty)) {
                    return AppLocalizations.of(context)!.wrongCredentials;
                  }
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.enterValidPassword;
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      validateUser(emailController, passwordController);
                    }
                  },
                  child: Text(AppLocalizations.of(context)!.signIn),
                ),
              ),
            ],
          ),
        )));
  }
}
