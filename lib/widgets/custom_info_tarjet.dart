import 'package:flutter/material.dart';

class CustomInfo extends StatelessWidget {
  //final Function() function;
  final Widget label;
  final Widget subtitle;
  final Image icon;
  final Color color;
  //final ButtonStyle style;
  final Widget button;
  final Function() funcion;

  const CustomInfo ({super.key, 
    //required this.function,
    required this.label,
    required this.subtitle,
    required this.icon,
    //required this.style,
    required this.button,
    required this.funcion, 
    required this.color,

  });


  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      shadowColor: color,
      elevation: 0.5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: icon,
            title: label,
            subtitle: subtitle,
            trailing: button,
            onTap: funcion,
          ),
        ],
      ),
    );
  }

}