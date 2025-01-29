import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inventario/Json/detailsp.dart';

import '../config/constants/enviroment.dart';
import '../widgets/custom_text_form.dart';

// ignore: must_be_immutable
class DetailsScreenP extends StatefulWidget {
  String text;
  // ignore: use_key_in_widget_constructors
  DetailsScreenP(this.text);

  @override
  State<DetailsScreenP> createState() => _DetailsScreenPState();
}

class _DetailsScreenPState extends State<DetailsScreenP> {
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
   final response = await dio.get('/getdetailsP.php', data: {
    "name":widget.text
   }); // texto

    final jsonResponse = json.decode(response.data);
    //print(jsonResponse);
    setState(() {
      for(final item in jsonResponse){ // se realiza un for para llamar cada 'Area' y mostrarla en el menu
        items.add( DetailsP.fromJson(item)); // se añade el 'area' al listado de items     
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
        body:  _ItemsList(),
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aquí puedes agregar la lógica que desees ejecutar al presionar el botón
          //print('Botón flotante presionado');
        },
        backgroundColor: const Color.fromARGB(255, 204, 7, 7), // Color de fondo del botón
        child: const Icon(Icons.remove_circle, color: Colors.white), // Icono del botón
      ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  ListView _ItemsList() {
    final screenSize = MediaQuery.of(context).size;
    return ListView.builder(
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
                padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.1),
                child:
                  TextFormFields(
                    //controller: ,
                    //hint: '24NR824', 
                    labelText: 'Area:', 
                    icono: const Icon(Icons.person_3), 
                    validators: (value){
                      return;
                    },
                    initialValue: list.idArea
                    //suffixIcon: IconButton(onPressed: scanBarcodeNormal, icon: const Icon(Icons.camera_alt_rounded),),
                    ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.1),
                child:
                  TextFormFields(
                    //controller: ,
                    //hint: '24NR824', 
                    labelText: 'Location:', 
                    icono: const Icon(Icons.person), 
                    validators: (value){
                      return;
                    },
                    initialValue: list.location
                    //suffixIcon: IconButton(onPressed: scanBarcodeNormal, icon: const Icon(Icons.camera_alt_rounded),),
                    ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.1),
                child:
                  TextFormFields(
                    //controller: ,
                    //hint: '24NR824', 
                    labelText: 'Serial:', 
                    icono: const Icon(Icons.date_range), 
                    validators: (value){
                      return;
                    },
                    initialValue: list.serial,
                    //suffixIcon: IconButton(onPressed: scanBarcodeNormal, icon: const Icon(Icons.camera_alt_rounded),),
                    ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.1),
                child:
                  TextFormFields(
                    //controller: ,
                    //hint: '24NR824', 
                    labelText: 'Name:', 
                    icono: const Icon(Icons.date_range), 
                    validators: (value){
                      return;
                    },
                    initialValue: list.name,
                    //suffixIcon: IconButton(onPressed: scanBarcodeNormal, icon: const Icon(Icons.camera_alt_rounded),),
                    ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.1),
                child:
                  TextFormFields(
                    //controller: ,
                    //hint: '24NR824', 
                    labelText: 'Ip:', 
                    icono: const Icon(Icons.numbers), 
                    validators: (value){
                      return;
                    },
                    initialValue: list.ip,
                    //suffixIcon: IconButton(onPressed: scanBarcodeNormal, icon: const Icon(Icons.camera_alt_rounded),),
                    ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.1),
                child:
                  TextFormFields(
                    //controller: ,
                    //hint: '24NR824', 
                    labelText: 'MAC:', 
                    icono: const Icon(Icons.check), 
                    validators: (value){
                      return;
                    },
                    initialValue: list.mac,
                    //suffixIcon: IconButton(onPressed: scanBarcodeNormal, icon: const Icon(Icons.camera_alt_rounded),),
                    ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.1),
                child:
                  TextFormFields(
                    //controller: ,
                    //hint: '24NR824', 
                    labelText: 'Type:', 
                    icono: const Icon(Icons.dvr), 
                    validators: (value){
                      return;
                    },
                    initialValue: list.tipo,
                    //suffixIcon: IconButton(onPressed: scanBarcodeNormal, icon: const Icon(Icons.camera_alt_rounded),),
                    ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.1),
                child:
                  TextFormFields(
                    //controller: ,
                    //hint: '24NR824', 
                    labelText: 'Observations:', 
                    icono: const Icon(Icons.headphones), 
                    validators: (value){
                      return;
                    },
                    initialValue: list.observation,
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
      );
  }
}