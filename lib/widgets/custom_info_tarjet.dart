import 'package:flutter/material.dart';

class CustomInfo extends StatelessWidget {
  final Function() function;
  final Widget label;
  final Icon icon;
  final ButtonStyle style;

  const CustomInfo ({super.key, 
    required this.function,
    required this.label,
    required this.icon,
    required this.style

  });


  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(onPressed: function,  label: label, icon: icon, style: style);
  }

}