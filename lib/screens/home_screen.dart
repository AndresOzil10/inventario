import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:inventario/widgets/custom_info_tarjet.dart';

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

  // ignore: non_constant_identifier_names
  Future Conteo() async {
   final response = await dio.get('/conteo.php'); // texto
    final jsonResponse = json.decode(response.data);
    setState(() {
      items = jsonResponse[0];
      //print(items);
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
      body: const _Preview() ,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: const _Menu(),
      drawer: const _Options(),
    );
  }
}

class _Options extends StatelessWidget {
  const _Options();

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
      );
  }
}

class _Preview extends StatelessWidget {
  const _Preview();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children:[
     CustomInfo(label: const Text('Equipo de Computo'), subtitle: const Text('Activos: 65'), icon: Image.asset('assets/images/1.gif'), button: const Text('Stock: 8')
     , color: const Color(0xfff1fbf5),),
     CustomInfo(label: const Text('Impresoras'), subtitle: const Text('Activas: 50'), icon: Image.asset('assets/images/2.gif'), button: const Text('Stock: 3'), color: const Color(0xfff1fbf5)),
     CustomInfo(label: const Text('Scanners'), subtitle: const Text('Activos: 50'), icon: Image.asset('assets/images/3.gif'), button: const Text('Stock: 5'), color: const Color(0xfff1fbf5)),
     CustomInfo(label: const Text('Raspberry Pi'), subtitle: const Text('Activas: 25'), icon: Image.asset('assets/images/4.gif'), button: const Text('Stock: 6'), color: const Color(0xfff1fbf5)),
     CustomInfo(label: const Text('Antenas'), subtitle: const Text('Activas: 18'), icon: Image.asset('assets/images/5.gif'), button: const Text('Stock: 1'), color: const Color(0xfff1fbf5)),
     CustomInfo(label: const Text('Maquinas'), subtitle: const Text('Activas: 38'), icon: Image.asset('assets/images/6.gif'), button: const Text('Stock: 0'), color: const Color(0xfff1fbf5)),
     CustomInfo(label: const Text('Terminales'), subtitle: const Text('Activas: 50'), icon: Image.asset('assets/images/7.gif'), button: const Text('Stock: 4'), color: const Color(0xfff1fbf5)),
     CustomInfo(label: const Text('Racks'), subtitle: const Text('Activas: 8'), icon: Image.asset('assets/images/8.gif'), button: const Text('Stock: 0'), color: const Color(0xfff1fbf5))
      
    ]);
  }
}


class _Menu extends StatelessWidget {
  const _Menu();

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      activeIcon: Icons.close_fullscreen,
      iconTheme: const IconThemeData(color: Colors.white),
      buttonSize: const Size(58, 58),
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          elevation: 0,
          child: const Icon(
          Icons.computer,
          color: Colors.blue,
        ),
        labelWidget: const Text('Add computer', style: TextStyle(color: Colors.black54),),
        backgroundColor: Colors.white30,
        onTap: () {
          context.push('/add');
        },
        ),
        SpeedDialChild(
          elevation: 0,
          child: const Icon(
          Icons.print,
          color: Colors.blue,
        ),
        labelWidget: const Text('Add Printer', style: TextStyle(color: Colors.black54),),
        backgroundColor: Colors.white30,
        onTap: () {
          context.push('/add');
        },
        ),
        SpeedDialChild(
          elevation: 0,
          child: const Icon(
          Icons.scanner,
          color: Colors.blue,
        ),
        labelWidget: const Text('Add Scanner', style: TextStyle(color: Colors.black54),),
        backgroundColor: Colors.white30,
        onTap: () {
          context.push('/add');
        },
        )
      ],
      child: const Icon(
        Icons.menu_open_rounded,
        color: Color(0xff1648c2),
      ),
    );
  }
}