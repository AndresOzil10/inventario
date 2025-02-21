import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventario/config/constants/enviroment.dart';
import 'package:inventario/widgets/custom_text_form.dart';
import 'package:signature/signature.dart';

import '../functions/pdf.dart';




// API
final dio = Dio(
    BaseOptions(
      baseUrl: Enviroment.apiUrl,
    )
  );

String name='', area='' ;

String tipo='', serial='';

//Obtener los datos del usuario
void _enviarNN(String nn) async {
  final response = await dio.post('/searchNN.php', data: {'nn': nn});
  if(response.statusCode == 200){

    final data =  jsonDecode(response.data);
    name = data['nombre'].toString();
    area = data['area'].toString();
    //print(name);
  }
  else{
    print('Error');
  }

}


class AsignarEquipoScreen extends StatefulWidget {

  
  const AsignarEquipoScreen({super.key});

  @override
  State<AsignarEquipoScreen> createState() => _AsignarEquipoScreenState();


}

class _AsignarEquipoScreenState extends State<AsignarEquipoScreen> {
  int _selectedLaptop = 0;
  int _selectedDocking = 0;
  int _selectedCargador= 0;
  int _selectedDiadema = 0;
  int _selectedMonitor = 0;
  int _selectedTecladoMouse = 0;
  int _selectedCamara = 0;
  List<String> laptops = [];
  List<String> dockings = [];
  List<String> monitors = [];
  List<String> tecladosMouse = [];
  List<String> diademas = [];
  List<String> cargadores = [];
  List<String> camara = [];

void _computers() async {
  final response = await dio.post('/computers.php');
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.data);
      for (var item in data) {
        String tipo = item['tipo'] as String;
        String serial = item['serial'] as String;

        laptops.add(serial);
      }
    }
}

 void _complements() async {
  try {
    final response = await dio.post('/complements.php');
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.data);

      // Filtrar los seriales por tipo
      for (var item in data) {
        String tipo = item['tipo'] as String;
        String serial = item['serial'] as String;

        switch (tipo) {
          case 'Docking':
            dockings.add(serial);
            break;
          case 'Monitor':
            monitors.add(serial);
            break;
          case 'Teclado/Mouse':
            tecladosMouse.add(serial);
            break;
          case 'Diadema':
            diademas.add(serial);
            break;
          case 'Cargador':
            cargadores.add(serial);
            break;
          case 'Camara':
            camara.add(serial);
            break;
        }
      }
    } else {
      print('Error: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _complements();
    _computers();
  }

  final userNN = TextEditingController();

  // ignore: unused_element
  void _save () async {
    generatePdf( name, laptops[_selectedLaptop]);
  }


// Muestra los datos seleccionados para la confirmacion
  void _showSelect() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Assign Equipment"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("NN: ${userNN.text}"),
            Text("Selected Laptop: ${laptops[_selectedLaptop]}"),
            Text("Selected Docking: ${dockings[_selectedDocking]}"),
            Text("Selected Cargador: ${cargadores.isNotEmpty ? cargadores[_selectedCargador] : '-'}"),
            Text("Selected Diadema: ${diademas[_selectedDiadema]}"),
            Text("Selected Monitor: ${monitors[_selectedMonitor]}"),
            Text("Selected Teclado/Mouse: ${tecladosMouse[_selectedTecladoMouse]}"),
            Text("Selected Camara: ${camara.isNotEmpty ? camara[_selectedCamara] : '-'}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              firma( name, laptops[_selectedLaptop], context );
            },
            child: const Text("Assign"),
          ),
        ],
      ),
    );
  }

// Para cargar la imagen desde assets

// Muestra el cuadro de dialogo
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Container(
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
                        onPressed: () {
                          String nn = userNN.text;

                          _enviarNN(nn);
                        },
                        label: const Text("Search"),
                        icon: const Icon(Icons.search),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          title: const Text("User Information"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Name: $name"),
                              Text("NN: ${userNN.text}"),
                              Text("Area: $area"),
                            ],
                          ),
                        ),
                        const ListTile(
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
                          height: screenSize.height * 0.01,
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
                              initialItem: _selectedLaptop,
                            ),
                            onSelectedItemChanged: (int selectedItem) {
                              setState(() {
                              _selectedLaptop = selectedItem;
                              });
                            },
                            children: List.generate(laptops.length, (int index) {
                              return Center(
                              child: Text(laptops[index]),
                              );
                            }),
                            ),
                          ),
                          child: Text(
                            laptops.isNotEmpty ? laptops[_selectedLaptop] : 'No Laptops Available',
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
                              children: List.generate(dockings.length, (int index){
                                return Center(
                                  child: Text(dockings[index]),
                                );
                              })
                            )
                          ), child: Text(
                            dockings.isNotEmpty ? dockings[_selectedDocking] : 'No Dockings Available',
                            style: const TextStyle(
                              color: Color(0xff364461),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Text("Cargador:"),
                        CupertinoButton(
                          padding: const EdgeInsets.all(10),
                          onPressed: () => _showDialog(
                            CupertinoPicker(
                            magnification: 1.22,
                            squeeze: 1.2,
                            useMagnifier: true,
                            itemExtent: 32,
                            scrollController: FixedExtentScrollController(
                              initialItem: _selectedCargador,
                            ),
                            onSelectedItemChanged: (int selectedItem) {
                              setState(() {
                              _selectedCargador = selectedItem;
                              });
                            },
                            children: List.generate(cargadores.length, (int index) {
                              return Center(
                              child: Text(cargadores[index]),
                              );
                            }),
                            ),
                          ),
                          child: Text(
                            cargadores.isNotEmpty ? cargadores[_selectedCargador] : 'No Laptops Available',
                            style: const TextStyle(
                            color: Color(0xff364461),
                            fontWeight: FontWeight.bold,
                            ),
                          ),
                          ),
                        const Text("Diadema:"),
                        CupertinoButton(
                          padding: const EdgeInsets.all(10),
                          onPressed: () => _showDialog(
                            CupertinoPicker(
                            magnification: 1.22,
                            squeeze: 1.2,
                            useMagnifier: true,
                            itemExtent: 32,
                            scrollController: FixedExtentScrollController(
                              initialItem: _selectedDiadema,
                            ),
                            onSelectedItemChanged: (int selectedItem) {
                              setState(() {
                              _selectedDiadema = selectedItem;
                              });
                            },
                            children: List.generate(diademas.length, (int index) {
                              return Center(
                              child: Text(diademas[index]),
                              );
                            }),
                            ),
                          ),
                          child: Text(
                            diademas.isNotEmpty ? diademas[_selectedDiadema] : 'No Diademas Available',
                            style: const TextStyle(
                            color: Color(0xff364461),
                            fontWeight: FontWeight.bold,
                            ),
                          ),
                          ),
                        const Text("Monitor:"),
                        CupertinoButton(
                          padding: const EdgeInsets.all(10),
                          onPressed: () => _showDialog(
                            CupertinoPicker(
                            magnification: 1.22,
                            squeeze: 1.2,
                            useMagnifier: true,
                            itemExtent: 32,
                            scrollController: FixedExtentScrollController(
                              initialItem: _selectedMonitor,
                            ),
                            onSelectedItemChanged: (int selectedItem) {
                              setState(() {
                              _selectedMonitor = selectedItem;
                              });
                            },
                            children: List.generate(monitors.length, (int index) {
                              return Center(
                              child: Text(monitors[index]),
                              );
                            }),
                            ),
                          ),
                          child: Text(
                            monitors.isNotEmpty ? monitors[_selectedMonitor] : 'No Laptops Available',
                            style: const TextStyle(
                            color: Color(0xff364461),
                            fontWeight: FontWeight.bold,
                            ),
                          ),
                          ),
                        const Text("Teclado/Mouse:"),
                        CupertinoButton(
                          padding: const EdgeInsets.all(10),
                          onPressed: () => _showDialog(
                            CupertinoPicker(
                            magnification: 1.22,
                            squeeze: 1.2,
                            useMagnifier: true,
                            itemExtent: 32,
                            scrollController: FixedExtentScrollController(
                              initialItem: _selectedTecladoMouse,
                            ),
                            onSelectedItemChanged: (int selectedItem) {
                              setState(() {
                              _selectedTecladoMouse = selectedItem;
                              });
                            },
                            children: List.generate(tecladosMouse.length, (int index) {
                              return Center(
                              child: Text(tecladosMouse[index]),
                              );
                            }),
                            ),
                          ),
                          child: Text(
                            tecladosMouse.isNotEmpty ? tecladosMouse[_selectedTecladoMouse] : 'No Laptops Available',
                            style: const TextStyle(
                            color: Color(0xff364461),
                            fontWeight: FontWeight.bold,
                            ),
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
      ),
    );
  }
}