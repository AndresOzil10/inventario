import 'package:flutter/material.dart';

import '../Json/dropdown_list.dart';
import '../widgets/custom_dropdown_list.dart';

// ignore: must_be_immutable
class AddComplemets extends StatelessWidget {
  AddComplemets({super.key});

  List<MenuItem> menuItems = [
    MenuItem(value: 'Docking', label: 'Docking', icon: Icons.laptop_chromebook),
    MenuItem(value: 'Diadema', label: 'Diadema', icon: Icons.laptop_mac_outlined),
    MenuItem(value: 'Camara', label: 'Camara', icon: Icons.credit_card),
    MenuItem(value: 'Teclado', label: 'Teclado', icon: Icons.monitor_rounded),
    MenuItem(value: 'Regulador', label: 'Regulador', icon: Icons.terminal)
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child:  Scaffold(
        body: Form(
          child: Column(
            children: [
              const SizedBox(
                      height: 20,
                    ),
              Title(color: Colors.red, child: const Text('Equipment Accessories', style: TextStyle(fontSize: 30, color: Colors.amber),)),
              const SizedBox(
                      height: 30,
                    ),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: CustomDropdownList(menuItems: menuItems)
              ),
              const SizedBox(
                      height: 40,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}