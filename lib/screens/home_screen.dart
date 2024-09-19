import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inventario/widgets/custom_info_tarjet.dart';

import '../Json/hostname.dart';
import '../config/constants/enviroment.dart';


// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var items = '';
  final dio = Dio(
    BaseOptions(
      baseUrl: Enviroment.apiUrl,
    )
  );

  @override
  void initState() {
    super.initState();
    Conteo();
    
  }

  Future Conteo() async {
   final response = await dio.get('/conteo.php'); // texto
    final jsonResponse = json.decode(response.data);
    setState(() {
      items = jsonResponse[0];
      print(items);
    });
 }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff364461),
        foregroundColor: const Color(0xffe0e4ce), //Color de letra
        centerTitle: true,
        title: const Text("Inventario Equipos Kayser"),
      ),
      body: GridView.count(
        crossAxisCount: 4,
        children:[
        CustomInfo(function: () {}, label: Text('Laptops Asignadas: 80'), icon: Icon(Icons.laptop), style: ButtonStyle(backgroundColor: WidgetStateProperty.all(const Color(0xffe12c58)))),
        FilledButton.icon(onPressed: () {}, label: const Text('Pc´s Asignadas: 28'), icon: const Icon(Icons.computer)),
        FilledButton.icon(onPressed: () {}, label: const Text('Garburgs Asignadas: 42'), icon: const Icon(Icons.print_rounded)),
        FilledButton.icon(onPressed: () {}, label: const Text('Impresoras RICOH: 15'), icon: const Icon(Icons.print_outlined)),
        FilledButton.icon(onPressed: () {}, label: const Text('Scaners Keyence: 35'), icon: const Icon(Icons.scanner_rounded)),
        FilledButton.icon(onPressed: () {}, label: const Text('Scaners: 30'), icon: const Icon(Icons.scanner)),
        FilledButton.icon(onPressed: () {}, label: const Text('Raspberry Activas: 25'), icon: const Icon(Icons.usb)),
        FilledButton.icon(onPressed: () {}, label: const Text('Maquinas Planta: 35'), icon: const Icon(Icons.work_outline)),
        FilledButton.icon(onPressed: () {}, label: const Text('Antenas Activas: 80'), icon: const Icon(Icons.wifi)),
        FilledButton.icon(onPressed: () {}, label: const Text('Terminales Activas: 45'), icon: const Icon(Icons.tv)),
        FilledButton.icon(onPressed: () {}, label: const Text('Racks: 14'), icon: const Icon(Icons.add_box_outlined)),
        FilledButton.icon(onPressed: () {}, label: const Text('Terminales Activas: 45'), icon: const Icon(Icons.laptop_chromebook_outlined)),
        FilledButton.icon(onPressed: () {}, label: const Text('Racks: 14'), icon: const Icon(Icons.laptop_chromebook_outlined)),
        FilledButton.icon(onPressed: () {}, label: const Text('Terminales Activas: 45'), icon: const Icon(Icons.laptop_chromebook_outlined)),
        FilledButton.icon(onPressed: () {}, label: const Text('Racks: 14'), icon: const Icon(Icons.laptop_chromebook_outlined)),
        FilledButton.icon(onPressed: () {}, label: const Text('Terminales Activas: 45'), icon: const Icon(Icons.laptop_chromebook_outlined)),
        FilledButton.icon(onPressed: () {}, label: const Text('Racks: 14'), icon: const Icon(Icons.laptop_chromebook_outlined)),
        FilledButton.icon(onPressed: () {}, label: const Text('Terminales Activas: 45'), icon: const Icon(Icons.laptop_chromebook_outlined)),
        FilledButton.icon(onPressed: () {}, label: const Text('Racks: 14'), icon: const Icon(Icons.laptop_chromebook_outlined)),
        FilledButton.icon(onPressed: () {}, label: const Text('Terminales Activas: 45'), icon: const Icon(Icons.laptop_chromebook_outlined)),
        FilledButton.icon(onPressed: () {}, label: const Text('Racks: 14'), icon: const Icon(Icons.laptop_chromebook_outlined)),
        FilledButton.icon(onPressed: () {}, label: const Text('Terminales Activas: 45'), icon: const Icon(Icons.laptop_chromebook_outlined)),
        FilledButton.icon(onPressed: () {}, label: const Text('Racks: 14'), icon: const Icon(Icons.laptop_chromebook_outlined)),
        FilledButton.icon(onPressed: () {}, label: const Text('Terminales Activas: 45'), icon: const Icon(Icons.laptop_chromebook_outlined)),
        FilledButton.icon(onPressed: () {}, label: const Text('Racks: 14'), icon: const Icon(Icons.laptop_chromebook_outlined)),
        FilledButton.icon(onPressed: () {}, label: const Text('Terminales Activas: 45'), icon: const Icon(Icons.laptop_chromebook_outlined)),
        FilledButton.icon(onPressed: () {}, label: const Text('Racks: 14'), icon: const Icon(Icons.laptop_chromebook_outlined)),
        FilledButton.icon(onPressed: () {}, label: const Text('Terminales Activas: 45'), icon: const Icon(Icons.laptop_chromebook_outlined)),
        FilledButton.icon(onPressed: () {}, label: const Text('Racks: 14'), icon: const Icon(Icons.laptop_chromebook_outlined)),
        FilledButton.icon(onPressed: () {}, label: const Text('Terminales Activas: 45'), icon: const Icon(Icons.laptop_chromebook_outlined)),
        FilledButton.icon(onPressed: () {}, label: const Text('Racks: 14'), icon: const Icon(Icons.laptop_chromebook_outlined)),
        FilledButton.icon(onPressed: () {}, label: const Text('Terminales Activas: 45'), icon: const Icon(Icons.laptop_chromebook_outlined)),
        FilledButton.icon(onPressed: () {}, label: const Text('Racks: 14'), icon: const Icon(Icons.laptop_chromebook_outlined)),
        FilledButton.icon(onPressed: () {}, label: const Text('Terminales Activas: 45'), icon: const Icon(Icons.laptop_chromebook_outlined)),
        FilledButton.icon(onPressed: () {}, label: const Text('Racks: 14'), icon: const Icon(Icons.laptop_chromebook_outlined)),
        FilledButton.icon(onPressed: () {}, label: const Text('Terminales Activas: 45'), icon: const Icon(Icons.laptop_chromebook_outlined)),
        FilledButton.icon(onPressed: () {}, label: const Text('Racks: 14'), icon: const Icon(Icons.laptop_chromebook_outlined)),
        FilledButton.icon(onPressed: () {}, label: const Text('Terminales Activas: 45'), icon: const Icon(Icons.laptop_chromebook_outlined)),
        FilledButton.icon(onPressed: () {}, label: const Text('Racks: 14'), icon: const Icon(Icons.laptop_chromebook_outlined)),
        FilledButton.icon(onPressed: () {}, label: const Text('Terminales Activas: 45'), icon: const Icon(Icons.laptop_chromebook_outlined)),
        FilledButton.icon(onPressed: () {}, label: const Text('Racks: 14'), icon: const Icon(Icons.laptop_chromebook_outlined)),
        FilledButton.icon(onPressed: () {}, label: const Text('Terminales Activas: 45'), icon: const Icon(Icons.laptop_chromebook_outlined)),
        FilledButton.icon(onPressed: () {}, label: const Text('Racks: 14'), icon: const Icon(Icons.laptop_chromebook_outlined)),
        FilledButton.icon(onPressed: () {}, label: const Text('Terminales Activas: 45'), icon: const Icon(Icons.laptop_chromebook_outlined)),
        FilledButton.icon(onPressed: () {}, label: const Text('Racks: 14'), icon: const Icon(Icons.laptop_chromebook_outlined)),
        FilledButton.icon(onPressed: () {}, label: const Text('Terminales Activas: 45'), icon: const Icon(Icons.laptop_chromebook_outlined)),
        FilledButton.icon(onPressed: () {}, label: const Text('Racks: 14'), icon: const Icon(Icons.laptop_chromebook_outlined)),
        
      ] ) ,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/add');
        },
        foregroundColor: const Color(0xfffff5de),
        backgroundColor: const Color(0xff35bf86),
        child: const Icon(Icons.add),
      ),
      drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children:  [
              const UserAccountsDrawerHeader(
              accountName: Text("Andrés Sanchez"),
              accountEmail: Text("mx-asanchez"),
              currentAccountPicture: CircleAvatar(backgroundColor: Colors.white),
              decoration: BoxDecoration(
                color: Color(0xff583b7e),
              ),
            ),
              const ListTile(
                title: Text('Home'),
                leading: Icon(Icons.home),
              ),
              ListTile(
                title: const Text('Asignar Equipo'),
                leading: const Icon(Icons.assignment),
                onTap: () => context.push('/asignar'),
              ),
              const ListTile(
                title: Text('Racks'),
                leading: Icon(Icons.tab),
              ),
            ],
          ),
        ),
    );
  }
}