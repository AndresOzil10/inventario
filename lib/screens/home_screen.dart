import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../Json/hostname.dart';
import '../config/constants/enviroment.dart';


// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        backgroundColor: const Color(0xff8c162a),
        foregroundColor: const Color(0xffffe4ff), //Color de letra
        centerTitle: true,
        title: const Text("Inventario Equipos Kayser"),
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
              onTap: () => context.push('/details'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/add');
        },
        foregroundColor: const Color(0xfffff5de),
        backgroundColor: const Color(0xff35bf86),
        child: const Icon(Icons.add),
      ),
    );
  }
}