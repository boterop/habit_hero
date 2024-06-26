import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:habit_hero/screens/sign_up.dart';
import 'package:habit_hero/services/api_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:habit_hero/services/user_service.dart';
import 'package:habit_hero/widgets/center_form_field.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
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

    forgotPassword() {
      throw UnimplementedError();
    }

    signIn(
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
          case {"data": Map data}:
            String id = data["id"];
            String token = data["token"];
            UserService.instance.updateUser(id, token);
            Navigator.pop(context, true);
            break;
        }
      });
    }

    signUp() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const SignUp()));
    }

    // facebookSignIn() {
    //   throw UnimplementedError();
    // }

    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(15.0),
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Icon(Icons.lock, size: 100),
                ),
                CenterFormField(
                    controller: emailController,
                    hint: AppLocalizations.of(context)!.email,
                    padding: 25.0,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!
                            .enterValid("email");
                      }
                      return null;
                    }),
                CenterFormField(
                  controller: passwordController,
                  hint: AppLocalizations.of(context)!.password,
                  padding: 25.0,
                  obscureText: true,
                  validator: (String? value) {
                    String email = emailController.text;
                    if (email.isNotEmpty && (value == null || value.isEmpty)) {
                      return AppLocalizations.of(context)!.wrongCredentials;
                    }
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!
                          .enterValid("password");
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25.0,
                    vertical: 10,
                  ),
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: RichText(
                      text: TextSpan(
                        text: AppLocalizations.of(context)!.forgotPassword,
                        style: TextStyle(color: Colors.grey[600]),
                        recognizer: TapGestureRecognizer()
                          ..onTap = forgotPassword,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 22.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            signIn(emailController, passwordController);
                          }
                        },
                        child: Text(AppLocalizations.of(context)!.signIn),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          signUp();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                        child: Text(AppLocalizations.of(context)!.signUp),
                      ),
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 50.0),
                //   child: Row(
                //     children: [
                //       const Expanded(
                //           child: Divider(indent: 25.0, endIndent: 5.0)),
                //       Text(AppLocalizations.of(context)!.orContinueWith),
                //       const Expanded(
                //           child: Divider(indent: 5.0, endIndent: 25.0)),
                //     ],
                //   ),
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     IconButton(
                //       icon: const Icon(Icons.facebook, size: 40),
                //       onPressed: facebookSignIn,
                //     )
                //   ],
                // )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
