import 'package:flutter/material.dart';
import 'package:temanbicara/app/themes/colors.dart';

class AuthTextfield extends StatelessWidget {
  final ValueChanged onChanged;
  final VoidCallback showPassword;
  final TextEditingController controller;
  final bool obscureText;
  final bool passwordField;
  final String hintText;
  final TextInputType type;

  const AuthTextfield({
    super.key,
    required this.onChanged,
    required this.showPassword,
    required this.controller,
    required this.obscureText,
    required this.hintText,
    required this.passwordField,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      cursorColor: black,
      obscureText: obscureText,
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: greyColor),
        suffixIcon: passwordField == true
            ? IconButton(
                icon: Icon(
                  obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 20,
                ),
                onPressed: showPassword,
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: greyColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: primaryColor),
        ),
      ),
    );
  }
}
