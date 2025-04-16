import 'package:flutter/material.dart';
import 'package:temanbicara/app/themes/colors.dart';

class AuthTextfield extends StatelessWidget {
  final ValueChanged onChanged;
  final VoidCallback showPassword;
  final TextEditingController controller;
  final bool obscureText;
  final bool passwordField;
  final String hintText;

  const AuthTextfield(
      {super.key,
      required this.onChanged,
      required this.showPassword,
      required this.controller,
      required this.obscureText,
      required this.hintText,
      required this.passwordField});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      cursorColor: black,
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: greyColor),
        suffixIcon: passwordField == true
            ? IconButton(
                icon: const Icon(Icons.remove_red_eye_outlined),
                onPressed: showPassword,
              )
            : null,
        suffixIconColor: const Color(0xFFc4c4c4),
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
