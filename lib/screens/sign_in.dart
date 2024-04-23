import 'package:flutter/material.dart';
import 'package:habit_hero/services/api_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email = "";
  String password = "";

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
    return Scaffold(
        appBar: AppBar(),
        body: Center(
            child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  hintText: '${AppLocalizations.of(context)!.email}:',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: '${AppLocalizations.of(context)!.password}:',
                ),
                obscureText: true,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      APIService()
                          .signIn(email: email, password: password)
                          .then((response) {
                        debugPrint(response);
                        debugPrint("$email:$password");
                      });
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
