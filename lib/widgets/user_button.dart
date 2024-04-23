import 'package:flutter/material.dart';

class UserButton extends StatelessWidget {
  final Widget route;
  const UserButton({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    onSignIn() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => route),
      );
    }

    return IconButton(
      icon: const Icon(Icons.person),
      onPressed: onSignIn,
    );
  }
}
