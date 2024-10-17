import 'package:flutter/material.dart';
import 'package:inventario/Json/dropdown_list.dart';

class CustomDropdownList extends StatefulWidget {
  final List<MenuItem> menuItems;
  const CustomDropdownList({super.key, required this.menuItems});

  @override
  State<CustomDropdownList> createState() => _CustomDropdownListState();
}

class _CustomDropdownListState extends State<CustomDropdownList> {
  final TextEditingController menuController = TextEditingController();

  MenuItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      //initialSelection: widget.menuItems.first,
      controller: menuController,
      width: MediaQuery.of(context).size.width-160.0,
      hintText: "Select Option",
      requestFocusOnTap: true,
      enableFilter: true,
      label: const Text('Type of Element:'),
      onSelected: (MenuItem? menu) {
        setState(() {
          selectedMenu = menu;
        });
      },
      dropdownMenuEntries: widget.menuItems.map<DropdownMenuEntry<MenuItem>>((MenuItem menu){
        return DropdownMenuEntry(value: menu, label: menu.label, leadingIcon: Icon(menu.icon));
      }).toList(),
    );
  }
}


