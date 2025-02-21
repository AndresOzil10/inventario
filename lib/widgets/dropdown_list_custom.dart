import 'package:flutter/material.dart';

import '../Json/dropdown_list.dart';

class DropdownListCustom extends StatelessWidget {

  final List<MenuItem> menuItems;
  final  TextEditingController controller;
  final Function onSelected;

  const DropdownListCustom({super.key, required this.menuItems, required this.controller, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}