import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:habit_hero/services/api_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:habit_hero/services/user_service.dart';
import 'package:habit_hero/widgets/center_form_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
    TextEditingController confirmPasswordController = TextEditingController();

    String error = "";

    forgotPassword() {
      throw UnimplementedError();
    }

    signUp() {
      String email = emailController.text;
      String password = passwordController.text;
      APIService().signUp(email: email, password: password).then((response) {
        debugPrint(response.toString());
        switch (response) {
          case {"errors": {"email": ["is not valid"]}}:
            error = AppLocalizations.of(context)!.enterValid("email");
            break;
          case {"errors": {"email": ["has already been taken"]}}:
            error = AppLocalizations.of(context)!.emailTaken;
            break;
          case {"data": Map data}:
            String id = data["id"];
            String token = data["token"];
            UserService.instance.updateUser(id, token);
            Navigator.popUntil(context, (route) => route.isFirst);
            break;
        }
        formKey.currentState!.validate();
      });
    }

    // facebookSignUp() {
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
                    if (error.isNotEmpty) {
                      String message = error;
                      error = "";
                      return message;
                    }
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.enterValid("email");
                    }
                    return null;
                  },
                ),
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
                CenterFormField(
                  controller: confirmPasswordController,
                  hint: AppLocalizations.of(context)!.confirmPassword,
                  padding: 25.0,
                  obscureText: true,
                  validator: (String? value) {
                    String password = passwordController.text;
                    String confirmPassword = confirmPasswordController.text;

                    if (password != confirmPassword) {
                      return AppLocalizations.of(context)!.passwordsDoNotMatch;
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
                            signUp();
                          }
                        },
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
                //       onPressed: facebookSignUp,
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
