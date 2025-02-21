import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../config/constants/enviroment.dart';
import '../widgets/custom_text_form.dart';
import '../widgets/data_time.dart';

final dio = Dio(
    BaseOptions(
      baseUrl: Enviroment.apiUrl,
    )
  );

class AddEquipment extends StatefulWidget {
  @override
  _AsignarEquipoScreenState createState() => _AsignarEquipoScreenState();
}

class _AsignarEquipoScreenState extends State<AddEquipment> {

   Future<void> _selectdate() async {
    DateTime? picked = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(),
      firstDate: DateTime(2017), 
      lastDate: DateTime(30000));

    if(picked != null ){
      setState(() {
        datePicked.text = picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> scanBarcodeNormal() async{
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.BARCODE);
      debugPrint(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = "Failed to get plataform version";
    }
    if(!mounted) return;
    setState(() {
      serialNumber.text = barcodeScanRes;
    });
    
  }
  
  Future<void> _selectFinal() async {
    DateTime? pick = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(),
      firstDate: DateTime(2017), 
      lastDate: DateTime(30000));

    if(pick != null ){
      setState(() {
        dateFinal.text = pick.toString().split(" ")[0];
      });
    }
  }

  final dateFinal = TextEditingController();
  final datePicked = TextEditingController();
  final serialNumber = TextEditingController();
  final description = TextEditingController();
  final model = TextEditingController();
  final type = TextEditingController();
  String message = '';
  String? _selectedEquipmentType;
  final List<String> equipmentTypes = ['Laptop', 'PC', 'Terminal', 'Docking', 'Cargador', 'Diadema', 'Monitor', 'Teclado/Mouse', 'Camara', 'Escaner', 'Impresora', 'Raspberry', 'Antena', 'Regulador'];

  Future<void> sendData() async {
  final data = {
    'serialNumber': serialNumber.text,
    'description': description.text,
    'model': model.text,
    'datePicked': datePicked.text,
    'dateFinal': dateFinal.text,
    'itemType': _selectedEquipmentType,
  };

  //print(data);

  try {
    final response = await dio.post('/insertC.php', data: data);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.data);
      message = data['status'].toString();
      if(message == 'success'){
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Element added successfully'),
            duration: Duration(seconds: 3),
          ),
        );
        serialNumber.clear();
        description.clear();
        model.clear();
        type.clear();
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error adding element'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } else {
      // Handle error
      debugPrint('Failed to send data');
    }
  } catch (e) {
    // Handle exception
    debugPrint('Error: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff364461),
          foregroundColor: const Color(0xffe0e4ce), // Color de letra
          centerTitle: true,
          title: const Text("Add Equipment"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(
                      height: 20,
                    ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: DropdownButtonFormField2(
                  isExpanded: false,
                  hint: const Text("Select Equipment Type"),
                  items: equipmentTypes.map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  )).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedEquipmentType = value;
                    });
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(Icons.arrow_drop_down),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (_selectedEquipmentType != null) ...[
                Text("Selected Equipment Type: $_selectedEquipmentType"),
                const SizedBox(height: 20),
                // Mostrar diferentes inputs según la selección
                if (_selectedEquipmentType == 'Laptop' || _selectedEquipmentType == 'PC') ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                      child:
                        TextFormFields(
                          controller: serialNumber,
                          hint: '24NR824', 
                          labelText: 'Servi Tag', 
                          icono: const Icon(Icons.computer), 
                          validators: (value){
                            return;
                          },
                          suffixIcon: IconButton(onPressed: scanBarcodeNormal, icon: const Icon(Icons.camera_alt_rounded),),
                          ),
                  ),
                  const SizedBox(
                      height: 25,
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child: DataTime(
                        controller: datePicked, 
                        labelText: 'Fecha Inicio Equipo', 
                        prefixIcon: const Icon(Icons.calendar_month), 
                        onTap: () { 
                          FocusManager.instance.primaryFocus?.unfocus();
                          _selectdate(); 
                          },
                      ),
                  ),
                  const SizedBox(
                      height: 25,
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                      child:
                        DataTime(
                          controller: dateFinal, 
                          labelText: 'Fecha Final Garantia', 
                          prefixIcon: const Icon(Icons.calendar_month), 
                          onTap: () { 
                            FocusManager.instance.primaryFocus?.unfocus();
                            _selectFinal(); 
                            },
                        )
                    ),

                ] else if (_selectedEquipmentType == 'Terminal') ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                      child:
                        TextFormFields(
                          controller: serialNumber,
                          hint: '24NR824', 
                          labelText: 'Servi Tag', 
                          icono: const Icon(Icons.computer), 
                          validators: (value){
                            return;
                          },
                          suffixIcon: IconButton(onPressed: scanBarcodeNormal, icon: const Icon(Icons.camera_alt_rounded),),
                          ),
                  ),
                  const SizedBox(
                      height: 25,
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                      child:
                        DataTime(
                          controller: dateFinal, 
                          labelText: 'Fecha Final Garantia', 
                          prefixIcon: const Icon(Icons.calendar_month), 
                          onTap: () { 
                            FocusManager.instance.primaryFocus?.unfocus();
                            _selectFinal(); 
                            },
                        )
                    ),

                ] else if (_selectedEquipmentType == 'Docking') ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child:
                      TextFormFields(
                        controller: serialNumber,
                        hint: '#####', 
                        labelText: 'Serial Number', 
                        icono: const Icon(Icons.dock), 
                        validators: (value){
                          return;
                        },
                        suffixIcon: IconButton(onPressed: scanBarcodeNormal, icon: const Icon(Icons.camera_alt_rounded),),
                        ),
                  ),
                  const SizedBox(
                          height: 40,
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child:
                      TextFormFields(
                        controller: description,
                        hint: 'Complemento .....' ,
                        labelText: 'Description:', 
                        icono: const Icon(Icons.description), 
                        validators: (value){
                          return;
                        }),
                  ),
                  const SizedBox(
                          height: 40,
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child:
                      TextFormFields(
                        controller: model,
                        hint: 'Dell, Logitech, .....' ,
                        labelText: 'Model:', 
                        icono: const Icon(Icons.model_training), 
                        validators: (value){
                          return;
                        }),
                  ),
                 
                ]else if (_selectedEquipmentType == 'Cargador') ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child:
                      TextFormFields(
                        controller: serialNumber,
                        hint: '#####', 
                        labelText: 'Serial Number', 
                        icono: const Icon(Icons.charging_station), 
                        validators: (value){
                          return;
                        },
                        suffixIcon: IconButton(onPressed: scanBarcodeNormal, icon: const Icon(Icons.camera_alt_rounded),),
                        ),
                  ),
                  const SizedBox(
                          height: 40,
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child:
                      TextFormFields(
                        controller: description,
                        hint: 'Complemento .....' ,
                        labelText: 'Description:', 
                        icono: const Icon(Icons.description), 
                        validators: (value){
                          return;
                        }),
                  ),
                  const SizedBox(
                          height: 40,
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child:
                      TextFormFields(
                        controller: model,
                        hint: 'Dell, Logitech, .....' ,
                        labelText: 'Model:', 
                        icono: const Icon(Icons.model_training), 
                        validators: (value){
                          return;
                        }),
                  ),

                ] else if (_selectedEquipmentType == 'Diadema') ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child:
                      TextFormFields(
                        controller: serialNumber,
                        hint: '#####', 
                        labelText: 'Serial Number', 
                        icono: const Icon(Icons.headset), 
                        validators: (value){
                          return;
                        },
                        suffixIcon: IconButton(onPressed: scanBarcodeNormal, icon: const Icon(Icons.camera_alt_rounded),),
                        ),
                  ),
                  const SizedBox(
                          height: 40,
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child:
                      TextFormFields(
                        controller: description,
                        hint: 'Complemento .....' ,
                        labelText: 'Description:', 
                        icono: const Icon(Icons.description), 
                        validators: (value){
                          return;
                        }),
                  ),
                  const SizedBox(
                          height: 40,
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child:
                      TextFormFields(
                        controller: model,
                        hint: 'Dell, Logitech, .....' ,
                        labelText: 'Model:', 
                        icono: const Icon(Icons.model_training), 
                        validators: (value){
                          return;
                        }),
                  ),

                ] else if (_selectedEquipmentType == 'Monitor') ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child:
                      TextFormFields(
                        controller: serialNumber,
                        hint: '#####', 
                        labelText: 'Serial Number', 
                        icono: const Icon(Icons.monitor), 
                        validators: (value){
                          return;
                        },
                        suffixIcon: IconButton(onPressed: scanBarcodeNormal, icon: const Icon(Icons.camera_alt_rounded),),
                        ),
                  ),
                  const SizedBox(
                          height: 40,
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child:
                      TextFormFields(
                        controller: description,
                        hint: 'Complemento .....' ,
                        labelText: 'Description:', 
                        icono: const Icon(Icons.description), 
                        validators: (value){
                          return;
                        }),
                  ),
                  const SizedBox(
                          height: 40,
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child:
                      TextFormFields(
                        controller: model,
                        hint: 'Dell, Logitech, .....' ,
                        labelText: 'Model:', 
                        icono: const Icon(Icons.model_training), 
                        validators: (value){
                          return;
                        }),
                  ),
                  
                ] else if (_selectedEquipmentType == 'Teclado/Mouse') ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child:
                      TextFormFields(
                        controller: serialNumber,
                        hint: '#####', 
                        labelText: 'Serial Number', 
                        icono: const Icon(Icons.keyboard), 
                        validators: (value){
                          return;
                        },
                        suffixIcon: IconButton(onPressed: scanBarcodeNormal, icon: const Icon(Icons.camera_alt_rounded),),
                        ),
                  ),
                  const SizedBox(
                          height: 40,
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child:
                      TextFormFields(
                        controller: description,
                        hint: 'Complemento .....' ,
                        labelText: 'Description:', 
                        icono: const Icon(Icons.description), 
                        validators: (value){
                          return;
                        }),
                  ),
                  const SizedBox(
                          height: 40,
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child:
                      TextFormFields(
                        controller: model,
                        hint: 'Dell, Logitech, .....' ,
                        labelText: 'Model:', 
                        icono: const Icon(Icons.model_training), 
                        validators: (value){
                          return;
                        }),
                  ),
                  
                ] else if (_selectedEquipmentType == 'Camara') ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child:
                      TextFormFields(
                        controller: serialNumber,
                        hint: '#####', 
                        labelText: 'Serial Number', 
                        icono: const Icon(Icons.camera_alt), 
                        validators: (value){
                          return;
                        },
                        suffixIcon: IconButton(onPressed: scanBarcodeNormal, icon: const Icon(Icons.camera_alt_rounded),),
                        ),
                  ),
                  const SizedBox(
                          height: 40,
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child:
                      TextFormFields(
                        controller: description,
                        hint: 'Complemento .....' ,
                        labelText: 'Description:', 
                        icono: const Icon(Icons.description), 
                        validators: (value){
                          return;
                        }),
                  ),
                  const SizedBox(
                          height: 40,
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child:
                      TextFormFields(
                        controller: model,
                        hint: 'Dell, Logitech, .....' ,
                        labelText: 'Model:', 
                        icono: const Icon(Icons.model_training), 
                        validators: (value){
                          return;
                        }),
                  ),
                 
                ] else if (_selectedEquipmentType == 'Escaner') ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child:
                      TextFormFields(
                        controller: serialNumber,
                        hint: '#####', 
                        labelText: 'Serial Number', 
                        icono: const Icon(Icons.scanner), 
                        validators: (value){
                          return;
                        },
                        suffixIcon: IconButton(onPressed: scanBarcodeNormal, icon: const Icon(Icons.camera_alt_rounded),),
                        ),
                  ),
                  const SizedBox(
                          height: 40,
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child:
                      TextFormFields(
                        controller: description,
                        hint: 'Keyence, Skorpio, .....' ,
                        labelText: 'Marca:', 
                        icono: const Icon(Icons.description), 
                        validators: (value){
                          return;
                        }),
                  ),
                  const SizedBox(
                          height: 40,
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child:
                      TextFormFields(
                        controller: model,
                        hint: 'BT-A500GA, DATALOGIC X4, .....' ,
                        labelText: 'Model:', 
                        icono: const Icon(Icons.model_training), 
                        validators: (value){
                          return;
                        }),
                  ),
                  const SizedBox(
                          height: 40,
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child: DataTime(
                        controller: datePicked, 
                        labelText: 'Fecha Llegada', 
                        prefixIcon: const Icon(Icons.calendar_month), 
                        onTap: () { 
                          FocusManager.instance.primaryFocus?.unfocus();
                          _selectdate(); 
                          },
                      ),
                  ),

                ] else if (_selectedEquipmentType == 'Impresora') ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child:
                      TextFormFields(
                        controller: serialNumber,
                        hint: '#####', 
                        labelText: 'Serial Number', 
                        icono: const Icon(Icons.print_rounded), 
                        validators: (value){
                          return;
                        },
                        suffixIcon: IconButton(onPressed: scanBarcodeNormal, icon: const Icon(Icons.camera_alt_rounded),),
                        ),
                  ),
                  const SizedBox(
                          height: 40,
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child:
                      TextFormFields(
                        controller: description,
                        hint: '12:34:56:78:90:AB' ,
                        labelText: 'MAC:', 
                        icono: const Icon(Icons.description), 
                        validators: (value){
                          return;
                        }),
                  ),
                  const SizedBox(
                          height: 40,
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child:
                      TextFormFields(
                        controller: model,
                        hint: 'RICOH, Vita II, Vario III, Zebra' ,
                        labelText: 'Model:', 
                        icono: const Icon(Icons.model_training), 
                        validators: (value){
                          return;
                        }),
                  ),
                  
                ] else if (_selectedEquipmentType == 'Raspberry') ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child:
                      TextFormFields(
                        controller: serialNumber,
                        hint: '#####', 
                        labelText: 'Serial Number', 
                        icono: const Icon(Icons.data_array), 
                        validators: (value){
                          return;
                        },
                        suffixIcon: IconButton(onPressed: scanBarcodeNormal, icon: const Icon(Icons.camera_alt_rounded),),
                        ),
                  ),
                  const SizedBox(
                          height: 40,
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child:
                      TextFormFields(
                        controller: description,
                        hint: 'Complemento .....' ,
                        labelText: 'Description:', 
                        icono: const Icon(Icons.description), 
                        validators: (value){
                          return;
                        }),
                  ),
                  const SizedBox(
                          height: 40,
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child:
                      TextFormFields(
                        controller: model,
                        hint: 'Dell, Logitech, .....' ,
                        labelText: 'Model:', 
                        icono: const Icon(Icons.model_training), 
                        validators: (value){
                          return;
                        }),
                  ),
                  
                ] else if (_selectedEquipmentType == 'Antena') ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child:
                      TextFormFields(
                        controller: serialNumber,
                        hint: '#####', 
                        labelText: 'Serial Number', 
                        icono: const Icon(Icons.wifi), 
                        validators: (value){
                          return;
                        },
                        suffixIcon: IconButton(onPressed: scanBarcodeNormal, icon: const Icon(Icons.camera_alt_rounded),),
                        ),
                  ),
                  const SizedBox(
                          height: 40,
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child: DataTime(
                        controller: datePicked, 
                        labelText: 'Fecha Llegada', 
                        prefixIcon: const Icon(Icons.calendar_month), 
                        onTap: () { 
                          FocusManager.instance.primaryFocus?.unfocus();
                          _selectdate(); 
                          },
                      ),
                  ),
                  
                ] else if (_selectedEquipmentType == 'Regulador') ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child:
                      TextFormFields(
                        controller: serialNumber,
                        hint: '#####', 
                        labelText: 'Serial Number', 
                        icono: const Icon(Icons.electrical_services), 
                        validators: (value){
                          return;
                        },
                        suffixIcon: IconButton(onPressed: scanBarcodeNormal, icon: const Icon(Icons.camera_alt_rounded),),
                        ),
                  ),
                  const SizedBox(
                          height: 40,
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child:
                      TextFormFields(
                        controller: description,
                        hint: 'Complemento .....' ,
                        labelText: 'Description:', 
                        icono: const Icon(Icons.description), 
                        validators: (value){
                          return;
                        }),
                  ),
                  const SizedBox(
                          height: 40,
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child:
                      TextFormFields(
                        controller: model,
                        hint: 'Dell, Logitech, .....' ,
                        labelText: 'Model:', 
                        icono: const Icon(Icons.model_training), 
                        validators: (value){
                          return;
                        }),
                  ),
                  
                ],
              ],
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child:
                    SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: sendData, 
                      label: const Text('Add'), 
                      icon: const Icon(Icons.add), 
                      style: TextButton.styleFrom(
                      foregroundColor: Colors.white, 
                      backgroundColor: Colors.red
                      ),
                    ),
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}