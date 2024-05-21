import 'package:flutter/material.dart';
import 'package:habit_hero/services/user_service.dart';

class UserButton extends StatefulWidget {
  final Widget route;
  final Function callback;
  const UserButton({super.key, required this.route, required this.callback});

  @override
  State<UserButton> createState() => _UserButtonState();
}

class _UserButtonState extends State<UserButton> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    isLoggedIn = UserService.instance.id.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    onSignOut() {
      UserService.instance.updateUser("", "");
      widget.callback();
      setState(() {
        isLoggedIn = false;
      });
    }

    onSignIn() {
      if (isLoggedIn) {
        onSignOut();
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => widget.route),
        ).then((value) {
          if (value) {
            setState(() {
              isLoggedIn = true;
            });
            widget.callback();
          }
        });
      }
    }

    return IconButton(
      icon: isLoggedIn ? const Icon(Icons.person) : const Icon(Icons.login),
      onPressed: onSignIn,
    );
  }
}
