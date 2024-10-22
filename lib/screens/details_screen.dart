import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inventario/Json/details.dart';

import '../config/constants/enviroment.dart';
import '../widgets/custom_text_form.dart';

// ignore: must_be_immutable
class InfoScreen extends StatefulWidget {
  String text;
  // ignore: use_key_in_widget_constructors
  InfoScreen(this.text);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  List items = [];
  final dio = Dio(
    BaseOptions(
      baseUrl: Enviroment.apiUrl,
    )
  );

  @override
  void initState() {
    super.initState();
    getDetails();
  }

   Future getDetails() async {
   final response = await dio.get('/getdetails.php', data: {
    "hostname":widget.text
   }); // texto

    final jsonResponse = json.decode(response.data);
    //print(jsonResponse);
    setState(() {
      for(final item in jsonResponse){ // se realiza un for para llamar cada 'Area' y mostrarla en el menu
        items.add( Details.fromJson(item)); // se añade el 'area' al listado de items     
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff364461),
          foregroundColor: const Color(0xffe0e4ce),  //Color de letra
          centerTitle: true,
          title: Text(widget.text),
        ),
        body:  ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final list = items[index];
            return Form(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child:
                    TextFormFields(
                      //controller: ,
                      //hint: '24NR824', 
                      labelText: 'Username:', 
                      icono: const Icon(Icons.person_3), 
                      validators: (value){
                        return;
                      },
                      initialValue: list.usuario,
                      //suffixIcon: IconButton(onPressed: scanBarcodeNormal, icon: const Icon(Icons.camera_alt_rounded),),
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child:
                    TextFormFields(
                      //controller: ,
                      //hint: '24NR824', 
                      labelText: 'Name:', 
                      icono: const Icon(Icons.person), 
                      validators: (value){
                        return;
                      },
                      initialValue: list.nombre,
                      //suffixIcon: IconButton(onPressed: scanBarcodeNormal, icon: const Icon(Icons.camera_alt_rounded),),
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child:
                    TextFormFields(
                      //controller: ,
                      //hint: '24NR824', 
                      labelText: 'Initial Date:', 
                      icono: const Icon(Icons.date_range), 
                      validators: (value){
                        return;
                      },
                      initialValue: list.fechaInicioEquipo.toString(),
                      //suffixIcon: IconButton(onPressed: scanBarcodeNormal, icon: const Icon(Icons.camera_alt_rounded),),
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child:
                    TextFormFields(
                      //controller: ,
                      //hint: '24NR824', 
                      labelText: 'Warranty End Date:', 
                      icono: const Icon(Icons.date_range), 
                      validators: (value){
                        return;
                      },
                      initialValue: list.fechaFinalGarantia.toString(),
                      //suffixIcon: IconButton(onPressed: scanBarcodeNormal, icon: const Icon(Icons.camera_alt_rounded),),
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child:
                    TextFormFields(
                      //controller: ,
                      //hint: '24NR824', 
                      labelText: 'Days Final Guarantee:', 
                      icono: const Icon(Icons.numbers), 
                      validators: (value){
                        return;
                      },
                      initialValue: list.diasFinGarantia,
                      //suffixIcon: IconButton(onPressed: scanBarcodeNormal, icon: const Icon(Icons.camera_alt_rounded),),
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child:
                    TextFormFields(
                      //controller: ,
                      //hint: '24NR824', 
                      labelText: 'Warranty Status:', 
                      icono: const Icon(Icons.check), 
                      validators: (value){
                        return;
                      },
                      initialValue: list.estatusGarantia,
                      //suffixIcon: IconButton(onPressed: scanBarcodeNormal, icon: const Icon(Icons.camera_alt_rounded),),
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child:
                    TextFormFields(
                      //controller: ,
                      //hint: '24NR824', 
                      labelText: 'Docking:', 
                      icono: const Icon(Icons.dvr), 
                      validators: (value){
                        return;
                      },
                      initialValue: list.docking,
                      //suffixIcon: IconButton(onPressed: scanBarcodeNormal, icon: const Icon(Icons.camera_alt_rounded),),
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child:
                    TextFormFields(
                      //controller: ,
                      //hint: '24NR824', 
                      labelText: 'Headphones:', 
                      icono: const Icon(Icons.headphones), 
                      validators: (value){
                        return;
                      },
                      initialValue: list.diadema,
                      //suffixIcon: IconButton(onPressed: scanBarcodeNormal, icon: const Icon(Icons.camera_alt_rounded),),
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child:
                    TextFormFields(
                      //controller: ,
                      //hint: '24NR824', 
                      labelText: 'Monitor', 
                      icono: const Icon(Icons.monitor), 
                      validators: (value){
                        return;
                      },
                      initialValue: list.monitor,
                      //suffixIcon: IconButton(onPressed: scanBarcodeNormal, icon: const Icon(Icons.camera_alt_rounded),),
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child:
                    TextFormFields(
                      //controller: ,
                      //hint: '24NR824', 
                      labelText: 'Keyboard/Mouse:', 
                      icono: const Icon(Icons.mouse), 
                      validators: (value){
                        return;
                      },
                      initialValue: list.tecladoMouse,
                      //suffixIcon: IconButton(onPressed: scanBarcodeNormal, icon: const Icon(Icons.camera_alt_rounded),),
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child:
                    TextFormFields(
                      //controller: ,
                      //hint: '24NR824', 
                      labelText: 'Camera:', 
                      icono: const Icon(Icons.camera), 
                      validators: (value){
                        return;
                      },
                      initialValue: list.camara,
                      //suffixIcon: IconButton(onPressed: scanBarcodeNormal, icon: const Icon(Icons.camera_alt_rounded),),
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child:
                    TextFormFields(
                      //controller: ,
                      //hint: '24NR824', 
                      labelText: 'Others:', 
                      icono: const Icon(Icons.devices_other), 
                      validators: (value){
                        return;
                      },
                      initialValue: list.otros,
                      //suffixIcon: IconButton(onPressed: scanBarcodeNormal, icon: const Icon(Icons.camera_alt_rounded),),
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child:
                    TextFormFields(
                      //controller: ,
                      //hint: '24NR824', 
                      labelText: 'Area:', 
                      icono: const Icon(Icons.area_chart), 
                      validators: (value){
                        return;
                      },
                      initialValue: list.area,
                      //suffixIcon: IconButton(onPressed: scanBarcodeNormal, icon: const Icon(Icons.camera_alt_rounded),),
                    ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Wrap(
                  children: [
                    FilledButton.icon(onPressed: (){}, label: const Text('Save'), icon: const Icon(Icons.save),style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Color(0xff3a4270))),),
                    /*const SizedBox(
                      width: 20,
                    ),
                    FilledButton.icon(onPressed: (){}, label: const Text('Delet Computer'), icon: const Icon(Icons.cancel), style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Color(0xfffb504e)),))*/
                  ],
                )
              ],
            ),
          );
          },
        )
      ),
    );
  }
}