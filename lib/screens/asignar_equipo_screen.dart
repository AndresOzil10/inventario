import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventario/widgets/custom_text_form.dart';
import 'package:transfer_list/transfer_list.dart';

const List<String> _fruitNames = <String>[
  'Apple',
  'Mango',
  'Banana',
  'Orange',
  'Pineapple',
  'Strawberry',
];

final List<String> _genderItems = <String>[
  'Male',
  'Female',
];

class AsignarEquipoScreen extends StatefulWidget {
  AsignarEquipoScreen({super.key});

  @override
  State<AsignarEquipoScreen> createState() => _AsignarEquipoScreenState();
}

class _AsignarEquipoScreenState extends State<AsignarEquipoScreen> {
  int _selectedFruit = 0;
  int _selectedDocking = 0;
  String? _selectedCargador;
  String? _selectedDiadema;
  String? _selectedMonitor;
  String? _selectedTecladoMouse;
  String? _selectedCamara;

  final userNN = TextEditingController();

  void _showSelect() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Assign Equipment"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("NN: ${userNN.text}"),
            Text("Selected Laptop: ${_fruitNames[_selectedFruit]}"),
            Text("Selected Docking: ${_genderItems[_selectedDocking]}"),
            Text("Selected Cargador: $_selectedCargador"),
            Text("Selected Diadema: $_selectedDiadema"),
            Text("Selected Monitor: $_selectedMonitor"),
            Text("Selected Teclado/Mouse: $_selectedTecladoMouse"),
            Text("Selected Camara: $_selectedCamara"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              // Aquí puedes agregar la lógica para asignar el equipo
              Navigator.pop(context);
            },
            child: const Text("Assign"),
          ),
        ],
      ),
    );
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff364461),
          foregroundColor: const Color(0xffe0e4ce), // Color de letra
          centerTitle: true,
          title: const Text("Assign Equipment"),
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(horizontal: screenSize.width * 0.03),
            width: double.infinity,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormFields(
                        controller: userNN,
                        labelText: 'NN:',
                        icono: const Icon(Icons.person_2_rounded),
                        hint: '0000 Juanito Perez',
                      ),
                    ),
                    const SizedBox(width: 8), // Espacio entre el TextFormField y el botón
                    TextButton.icon(
                      onPressed: () {},
                      label: const Text("Search"),
                      icon: const Icon(Icons.search),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenSize.height * 0.05,
                ),
                const Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text("User Information"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Name: Juanito Perez"),
                            Text("NN: 0000"),
                            Text("Area: 1"),
                          ],
                        ),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Equipment Information"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Serial: -"),
                            Text("Model: -"),
                            Text("Brand: -"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.01,
                ),
                const Divider(),
                Card(
                  child: Column(
                    children: [
                      const Text("Asignar Nuevos Equipos"),
                      SizedBox(
                        height: screenSize.height * 0.05,
                      ),
                      const Text("Laptop:"),
                      CupertinoButton(
                        padding: const EdgeInsets.all(10),
                        onPressed: () => _showDialog(
                          CupertinoPicker(
                            magnification: 1.22,
                            squeeze: 1.2,
                            useMagnifier: true,
                            itemExtent: 32, 
                            scrollController: FixedExtentScrollController(
                              initialItem: _selectedFruit,
                            ),
                            onSelectedItemChanged: (int selectedItem){
                              setState((){
                                _selectedFruit = selectedItem;
                              });
                            }, 
                            children: List.generate(_fruitNames.length, (int index){
                              return Center(
                                child: Text(_fruitNames[index]),
                              );
                            })
                          )
                        ), child: Text(
                          _fruitNames[_selectedFruit],
                          style: const TextStyle(
                            color: Color(0xff364461),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Text("Docking:"),
                      CupertinoButton(
                        padding: const EdgeInsets.all(10),
                        onPressed: () => _showDialog(
                          CupertinoPicker(
                            magnification: 1.22,
                            squeeze: 1.2,
                            useMagnifier: true,
                            itemExtent: 32, 
                            scrollController: FixedExtentScrollController(
                              initialItem: _selectedDocking,
                            ),
                            onSelectedItemChanged: (int selectedItem){
                              setState((){
                                _selectedDocking = selectedItem;
                              });
                            }, 
                            children: List.generate(_genderItems.length, (int index){
                              return Center(
                                child: Text(_genderItems[index]),
                              );
                            })
                          )
                        ), child: Text(
                          _genderItems[_selectedDocking],
                          style: const TextStyle(
                            color: Color(0xff364461),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Text("Cargador:"),
                      DropdownButtonFormField2(
                        isExpanded: true,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        hint: const Text("Select Cargador"),
                        style: const TextStyle(fontSize: 14),  
                        items: _genderItems.map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(item , style: const TextStyle(fontSize: 14, color: Colors.black),),
                        )).toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a Cargador';
                          }
                          return null;
                        },
                        onChanged: (value) => print(value),
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.only(right: 8)
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Color(0xff364461),
                          ),
                          iconSize: 24
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)
                          )
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16)
                        ),
                      ),
                      const Text("Docking:"),
                      DropdownButtonFormField2(
                        isExpanded: true,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        hint: const Text("Select Docking"),
                        style: const TextStyle(fontSize: 14),  
                        items: _genderItems.map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(item , style: const TextStyle(fontSize: 14, color: Colors.black),),
                        )).toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select Docking';
                          }
                          return null;
                        },
                        onChanged: (value) => print(value),
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.only(right: 8)
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Color(0xff364461),
                          ),
                          iconSize: 24
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)
                          )
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16)
                        ),
                      ),
                      const Text("Diadema:"),
                      DropdownButtonFormField2(
                        isExpanded: true,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        hint: const Text("Select Diadema"),
                        style: const TextStyle(fontSize: 14),  
                        items: _genderItems.map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(item , style: const TextStyle(fontSize: 14, color: Colors.black),),
                        )).toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a Diadema';
                          }
                          return null;
                        },
                        onChanged: (value) => print(value),
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.only(right: 8)
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Color(0xff364461),
                          ),
                          iconSize: 24
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)
                          )
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16)
                        ),
                      ),
                      const Text("Monitor:"),
                      DropdownButtonFormField2(
                        isExpanded: true,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        hint: const Text("Select Monitor"),
                        style: const TextStyle(fontSize: 14),  
                        items: _genderItems.map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(item , style: const TextStyle(fontSize: 14, color: Colors.black),),
                        )).toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a Monitor';
                          }
                          return null;
                        },
                        onChanged: (value) => print(value),
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.only(right: 8)
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Color(0xff364461),
                          ),
                          iconSize: 24
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)
                          )
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16)
                        ),
                      ),
                      const Text("Teclado/Mouse:"),
                      DropdownButtonFormField2(
                        isExpanded: true,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        hint: const Text("Select Teclado/Mouse"),
                        style: const TextStyle(fontSize: 14),  
                        items: _genderItems.map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(item , style: const TextStyle(fontSize: 14, color: Colors.black),),
                        )).toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a Teclado/Mouse';
                          }
                          return null;
                        },
                        onChanged: (value) => print(value),
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.only(right: 8)
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Color(0xff364461),
                          ),
                          iconSize: 24
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)
                          )
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16)
                        ),
                      ),
                      const Text("Camara:"),
                      DropdownButtonFormField2(
                        isExpanded: true,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        hint: const Text("Select Monitor"),
                        style: const TextStyle(fontSize: 14),  
                        items: _genderItems.map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(item , style: const TextStyle(fontSize: 14, color: Colors.black),),
                        )).toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a Monitor';
                          }
                          return null;
                        },
                        onChanged: (value) => print(value),
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.only(right: 8)
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Color(0xff364461),
                          ),
                          iconSize: 24
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)
                          )
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16)
                        ),
                      ),
                    ],
                    ),
                ),
                TextButton(
                  onPressed: () => _showSelect(),
                  child: const Text("Assign"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}