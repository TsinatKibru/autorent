import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscureText;
  final Widget? suffixIcon; // New optional parameter for suffix icon

  const AuthField({
    super.key,
    required this.hintText,
    // required this.controller,
    this.isObscureText = false,
    this.suffixIcon,
    required this.controller, // Initialize suffixIcon
  });

  @override
  Widget build(BuildContext context) {
    bool isEmailField = hintText
        .toLowerCase()
        .contains('email'); // Check if hintText indicates email

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon, // Add suffix icon to InputDecoration
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is missing!";
        }
        return null;
      },
      keyboardType:
          isEmailField ? TextInputType.emailAddress : TextInputType.text,
      obscureText: isObscureText,
    );
  }
}
