import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../Json/hostname.dart';
import '../config/constants/enviroment.dart';
import 'details_screen.dart';


// ignore: must_be_immutable
class InfScreen extends StatefulWidget {
  const InfScreen({super.key });

  @override
  State<InfScreen> createState() => _InfScreenState();
}

class _InfScreenState extends State<InfScreen> {
  List items = [];
  final dio = Dio(
    BaseOptions(
      baseUrl: Enviroment.apiUrl,
    )
  );

  @override
  void initState() {
    super.initState();
    getData();
    
  }

  Future getData() async {
   final response = await dio.get('/getdata.php'); // texto
    final jsonResponse = json.decode(response.data);
    setState(() {
      for(final item in jsonResponse){ // se realiza un for para llamar cada 'Area' y mostrarla en el menu
        items.add( HostName.fromJson(item)); // se añade el 'area' al listado de items
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
              title: Text(list.hostname),
              titleTextStyle: const TextStyle( color: Color(0xff8c162a)),
              trailing: const Icon(Icons.arrow_right_rounded),
              onTap: () =>{
                Navigator.push(context, MaterialPageRoute(builder: (context) => InfoScreen(list.hostname)))
              } //context.push('/details'),
            ),
          );
        },
      ),
    );
  }
}


