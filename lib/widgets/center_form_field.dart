import 'package:flutter/material.dart';

class CenterFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final Function validator;
  final bool obscureText;
  final TextInputType keyboardType;
  final int minLines;
  final int maxLines;
  final InputBorder? border;
  final Widget? prefixIcon;

  const CenterFormField({
    super.key,
    required this.controller,
    required this.hint,
    required this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.minLines = 1,
    this.maxLines = 1,
    this.border,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: '$hint:',
            border: border,
            prefixIcon: prefixIcon,
          ),
          obscureText: obscureText,
          keyboardType: keyboardType,
          minLines: minLines,
          maxLines: maxLines,
          validator: (String? value) => validator(value),
        ),
      );
}
