import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inventario/Json/scanners.dart';
import 'package:inventario/screens/details_screenp.dart';
import 'package:inventario/screens/details_screens.dart';

import '../Json/printers.dart';
import '../config/constants/enviroment.dart';


// ignore: must_be_immutable
class InfScreenS extends StatefulWidget {
  const InfScreenS({super.key});

  @override
  State<InfScreenS> createState() => _InfScreenSState();
}

class _InfScreenSState extends State<InfScreenS> {
  List items = [];

  final dio = Dio(
    BaseOptions(
      baseUrl: Enviroment.apiUrl,
    )
  );

  @override
  void initState() {
    super.initState();
    //print(widget.extraData);
    getData();
    
  }

  Future getData() async {
      final response = await dio.get('/getdataS.php');
      //print(response.data);
        final jsonResponse = json.decode(response.data);
        setState(() {
          for(final item in jsonResponse){ // se realiza un for para llamar cada 'Area' y mostrarla en el menu
            items.add( Scanner.fromJson(item)); // se añade el 'area' al listado de items
          }
        });
 }

 

  @override
  Widget build(BuildContext context) { 
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff364461),
        foregroundColor: const Color(0xffe0e4ce), //Color de letra
        centerTitle: true,
        title: const Text("Equipment Inventory Kayser"),
      ),
      body:  ListView.builder(
        itemCount: items.length,
        itemBuilder:(context, index) {
          final list = items[index];
          return Card(
            child: ListTile(
              title: Text(list.serial),
              titleTextStyle: const TextStyle( color: Color(0xff8c162a)),
              trailing: const Icon(Icons.arrow_right_rounded),
              onTap: () =>{
                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreenS(list.serial)))
              } //context.push('/details'),
            ),
          );
        },
      ),
    );
  }
}


