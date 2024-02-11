
import 'package:flutter/material.dart';

class TextFieldComponent extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction ;
  final String hintText;
  final Icon? prefixIcon;
  final Widget? suffixIcon ;
  final bool obscureText;
  final String? Function(String?)? validator;


  const TextFieldComponent(
      {super.key,
        required this.hintText,
        required this.controller,
        this.keyboardType,
        this.textInputAction,
        this.obscureText = false,
        this.suffixIcon,
        this.validator,
        this.prefixIcon });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        padding: EdgeInsets.all(5),
        child: TextFormField(
          validator: validator,
          obscureText: obscureText,
          controller: controller,
          textInputAction:textInputAction,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),

        ),
      ),
    );
  }
}