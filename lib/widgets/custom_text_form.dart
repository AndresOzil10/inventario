import 'package:flutter/material.dart';

class TextFormFields extends StatelessWidget {
  final String? hint;
  final String labelText;
  final Icon icono;
  final String? Function(String?)? validators;
  final bool oscureText;
  final Widget? suffixIcon;
  final TextEditingController? controller;

  const TextFormFields(
      {super.key,
      this.hint,
      required this.labelText,
      required this.icono,
      this.validators,
      this.oscureText = false, this.suffixIcon, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      controller: controller,
      obscureText: oscureText,
      decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffFF9EAA))),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffD2649A), width: 2)),
          hintText: hint,
          suffixIcon: suffixIcon,
          labelText: labelText,
          labelStyle: const TextStyle(
              color: Color(0xffD10363), fontWeight: FontWeight.bold),
          prefixIcon: icono,
          prefixIconColor: const Color(0xffD2649A)),
      validator: validators,
    );
  }
}
