import 'package:flutter/material.dart';

class CenterFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final Function validator;
  final bool obscureText;

  const CenterFormField({
    super.key,
    required this.controller,
    required this.hint,
    required this.validator,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: '$hint:',
          ),
          obscureText: obscureText,
          validator: (String? value) => validator(value),
        ),
      );
}
