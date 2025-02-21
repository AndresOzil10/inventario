import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../config/constants/enviroment.dart';

final dio = Dio(
    BaseOptions(
      baseUrl: Enviroment.apiUrl,
    )
  );

class Printer {
  String name;
  int tonerLevelB;
  int tonerLevelC;
  int tonerLevelM;

  Printer({required this.name, required this.tonerLevelB, required this.tonerLevelC, required this.tonerLevelM});
}

class TonnerScreen extends StatefulWidget {
  const TonnerScreen({super.key});

  
  @override
  State<TonnerScreen> createState() => _TonnerScreenState();
}
  @override
 


class _TonnerScreenState extends State<TonnerScreen> {

  List<String> ricoh = [];

  void _showAddPrinterDialog() {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController tonerLevelController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Agregar nueva impresora'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nombre de la impresora'),
            ),
            TextField(
              controller: tonerLevelController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Nivel de tóner'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              String name = nameController.text;
              int tonerLevel = int.parse(tonerLevelController.text);
              Navigator.of(context).pop();
            },
            child: const Text('Agregar'),
          ),
        ],
      );
    },
  );
}


  void _printers() async {
  final response = await dio.post('/ricoh.php');
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.data);
      for (var item in data) {
        String name = item['name'] as String;
        //String serial = item['serial'] as String;

        ricoh.add(name);
        //print(ricoh);
      }
    }
}


   @override
     void initState() {
    super.initState();
    _printers();
    
  }

  final List<Printer> printers = [
    Printer(name: 'Impresora 1', tonerLevelB: 80, tonerLevelC: 50, tonerLevelM: 25),
    Printer(name: 'Impresora 2', tonerLevelB: 50, tonerLevelC: 50, tonerLevelM: 25),
    Printer(name: 'Impresora 3', tonerLevelB: 25, tonerLevelC: 50, tonerLevelM: 25),
    Printer(name: 'Impresora 4', tonerLevelB: 24, tonerLevelC: 50, tonerLevelM: 25),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(backgroundColor: const Color(0xff364461),
            foregroundColor: const Color(0xffe0e4ce), // Color de letra
            centerTitle: true,
            title: const Text("Printers Check"),
          ),
        body: ListView.builder(
          itemCount: printers.length,
          itemBuilder: (context, index) {
            final printer = printers[index];
            return Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(printer.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nivel de tóner Black: ${printer.tonerLevelB}'),
                    LinearProgressIndicator(
                      value: printer.tonerLevelB / 100,
                      color: printer.tonerLevelB >= 75
                        ? Colors.green
                        : printer.tonerLevelB >= 50
                          ? Colors.orange
                          : printer.tonerLevelB >= 25
                            ? Colors.yellow
                            : Colors.red,
                    ),
                    Text('Nivel de tóner Cian: ${printer.tonerLevelC}'),
                    LinearProgressIndicator(
                      value: printer.tonerLevelC / 100,
                      color: printer.tonerLevelC >= 75
                        ? Colors.green
                        : printer.tonerLevelC >= 50
                          ? Colors.orange
                          : printer.tonerLevelC >= 25
                            ? Colors.yellow
                            : Colors.red,
                    ),
                    Text('Nivel de tóner Magenta: ${printer.tonerLevelM}'),
                    LinearProgressIndicator(
                      value: printer.tonerLevelM / 100,
                      color: printer.tonerLevelM >= 75
                        ? Colors.green
                        : printer.tonerLevelM >= 50
                          ? Colors.orange
                          : printer.tonerLevelM >= 25
                            ? Colors.yellow
                            : Colors.red,
                    ),
                  ],
                ),   
                leading: const Icon(Icons.warning),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // Lógica para actualizar el nivel de tóner
                    _showUpdateDialog(context, printer);
                  },
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showAddPrinterDialog();
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _showUpdateDialog(BuildContext context, Printer printer) {
    final TextEditingController controller = TextEditingController(text: printer.tonerLevelB.toString());
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Actualizar nivel de tóner de ${printer.name}'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Nuevo nivel de tóner'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Lógica para actualizar el nivel de tóner
                int newLevel = int.parse(controller.text);
                printer.tonerLevelB = newLevel; // Actualiza el nivel de tóner
                Navigator.of(context).pop();
              },
              child: const Text('Actualizar'),
            ),
          ],
        );
      },
    );
  }
}

