import 'package:flutter/material.dart';

class DataTime extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final Widget prefixIcon;
  final Function() onTap;

  const DataTime({super.key, required this.controller, required this.labelText, required this.prefixIcon, required this.onTap});
  
  @override
  Widget build(BuildContext context) {

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon,
        enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffFF9EAA))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffD2649A), width: 2)),
      ),
      onTap: onTap
    );
    
  }
}