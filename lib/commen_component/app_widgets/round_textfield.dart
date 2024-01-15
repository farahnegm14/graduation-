
import 'package:flutter/material.dart';


class TextFieldComponent extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction ;
  final String labelText;
  final Icon? prefixIcon;
  final Widget? suffixIcon ;
  final bool obscureText;

  const TextFieldComponent(
      {super.key,
        required this.labelText,
        required this.controller,
        this.keyboardType,
        this.textInputAction,
        this.obscureText = false,
        this.suffixIcon,
        this.prefixIcon });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      textInputAction:textInputAction,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),

    );
  }
}