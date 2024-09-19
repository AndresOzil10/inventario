import 'package:flutter/material.dart';
import 'package:inventario/widgets/custom_text_form.dart';

import '../widgets/data_time.dart';


class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {

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

  final datePicked = TextEditingController();
  final dateFinal = TextEditingController();

  final serialNumber = TextEditingController();
  final inicioEquipo = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff364461),
          foregroundColor: const Color(0xffe0e4ce),  //Color de letra
          centerTitle: true,
          title: const Text("Añadir Nuevos Equipos"),
        ),
        body: Container(
          child:
            Form(
              child: Column(
                children: [
                  const SizedBox(
                          height: 40,
                        ),
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
                        }
                        ),
                        
                ),
                const SizedBox(
                          height: 25,
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child:
                      DataTime(
                        controller: datePicked, 
                        labelText: 'Fecha Inicio Equipo', 
                        prefixIcon: const Icon(Icons.calendar_month), 
                        onTap: () { 
                          FocusManager.instance.primaryFocus?.unfocus();
                          _selectdate(); 
                          },
                      )
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
                ]
              ),
            )
        ),
      ),
    );
  }
}