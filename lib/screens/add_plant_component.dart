import 'package:flutter/material.dart';

import '../Json/dropdown_list.dart';
import '../widgets/custom_dropdown_list.dart';

// ignore: must_be_immutable
class AddPlantComponent extends StatelessWidget {
  AddPlantComponent({super.key});

  List<MenuItem> menuItems = [
    MenuItem(value: 'Antena', label: 'Antena', icon: Icons.wifi),
    MenuItem(value: 'Vario', label: 'Garburg Vario', icon: Icons.print),
    MenuItem(value: 'Vita', label: 'Garburg Vita', icon: Icons.print_disabled_rounded),
    MenuItem(value: 'RICOH', label: 'Impresora RICOH', icon: Icons.print_outlined),
    MenuItem(value: 'Keyence', label: 'Escaner Keyence', icon: Icons.scanner),
    MenuItem(value: 'Scanner', label: 'Scanner', icon: Icons.scanner_outlined),

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
              Title(color: Colors.red, child: const Text('Plant Accesories', style: TextStyle(fontSize: 30, color: Colors.amber),)),
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