import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:inventario/widgets/custom_info_tarjet.dart';

import '../config/constants/enviroment.dart';


// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  String usuario;

  HomeScreen(this.usuario, {super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> items = [];
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
      items = jsonResponse.values.toList();
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
        title: const Text("Equipment Inventory Kayser", style: TextStyle(fontSize: 21),),
      ),
      body: _Preview(items: items) ,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: const _Menu(),
      drawer: _Options(widget.usuario),
    );
  }
}

// ignore: must_be_immutable
class _Options extends StatelessWidget {
  String user;
  _Options(this.user);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children:  [
            UserAccountsDrawerHeader(
            accountName: Text(user),
            accountEmail: const Text(''),
            currentAccountPicture: const CircleAvatar(backgroundColor: Colors.white),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 212, 11, 38),
            ),
          ),
            const ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home, color: Colors.blueAccent,),
            ),
            ListTile(
              title: const Text('Assign Equipment'),
              leading: const Icon(Icons.assignment, color: Colors.blueAccent,),
              onTap: () => context.push('/asignar'),
            ),
            ListTile(
              title: const Text('Tonners'),
                leading: const Icon(Icons.tonality, color: Colors.blueAccent),
              onTap: () => context.push('/tonner')),
            ListTile(
              title: const Text('Schedule Maintenance'),
              leading: const Icon(Icons.schedule_outlined, color: Colors.blueAccent,),
              onTap: () => context.push('/maintenace'),
            ),
          ],
        ),
      );
  }
}

class _Preview extends StatelessWidget {
  final List<dynamic> items;
  const _Preview({required this.items});
  //final dato = items;;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(child: Image.asset('assets/images/load.gif'));
    }
    return ListView(
        
        children:[
        const SizedBox(height: 20,),
        CustomInfo(label: const Text('Computer Equipment', style: TextStyle(fontWeight: FontWeight.bold),), subtitle: Text('Online: ${items[0]}', style: const TextStyle(fontWeight: FontWeight.bold)), icon: Image.asset('assets/images/1.gif'), button: Text('Stock: ${items[1]}', style: const TextStyle(fontWeight: FontWeight.bold)), color: const Color.fromARGB(177, 209, 209, 209), funcion: () => { context.push('/infoC') },),
        const SizedBox(height: 20,),
        CustomInfo(label: const Text('Printers', style: TextStyle(fontWeight: FontWeight.bold)), subtitle: Text('Online: ${items[2]}', style: const TextStyle(fontWeight: FontWeight.bold)), icon: Image.asset('assets/images/2.gif'), button: Text('Stock: ${items[3]}', style: const TextStyle(fontWeight: FontWeight.bold)), color: const Color.fromARGB(177, 209, 209, 209), funcion: () => { context.push('/infoP') },),
        const SizedBox(height: 20,),
        CustomInfo(label: const Text('Scanners', style: TextStyle(fontWeight: FontWeight.bold)), subtitle: Text('Online: ${items[4]}', style: const TextStyle(fontWeight: FontWeight.bold)), icon: Image.asset('assets/images/3.gif'), button: Text('Stock: ${items[5]}', style: const TextStyle(fontWeight: FontWeight.bold)), color: const Color.fromARGB(177, 209, 209, 209), funcion: () => { context.push('/infoS') },),
        const SizedBox(height: 20,),
        CustomInfo(label: const Text('Raspberry Pi', style: TextStyle(fontWeight: FontWeight.bold)), subtitle: const Text('Online: 25', style: TextStyle(fontWeight: FontWeight.bold)), icon: Image.asset('assets/images/4.gif'), button: const Text('Stock: 6', style: TextStyle(fontWeight: FontWeight.bold)), color: const Color.fromARGB(177, 209, 209, 209), funcion: () {  },),
        const SizedBox(height: 20,),
        CustomInfo(label: const Text('Antenas', style: TextStyle(fontWeight: FontWeight.bold)), subtitle: Text('Online: ${items[6]}', style: const TextStyle(fontWeight: FontWeight.bold)), icon: Image.asset('assets/images/5.gif'), button: Text('Stock: ${items[7]}', style: const TextStyle(fontWeight: FontWeight.bold)), color: const Color.fromARGB(177, 209, 209, 209), funcion: () {  },),
        // const SizedBox(height: 20,),
        // CustomInfo(label: const Text('Machines'), subtitle: const Text('Online: 38'), icon: Image.asset('assets/images/6.gif'), button: const Text('Stock: 0'), color: const Color(0xfff9d423), funcion: () {  },),
        const SizedBox(height: 20,),
        CustomInfo(label: const Text('Terminals', style: TextStyle(fontWeight: FontWeight.bold)), subtitle: const Text('Online: 50', style: TextStyle(fontWeight: FontWeight.bold)), icon: Image.asset('assets/images/7.gif'), button: const Text('Stock: 4', style: TextStyle(fontWeight: FontWeight.bold)), color: const Color.fromARGB(177, 209, 209, 209), funcion: () {  },),
        // const SizedBox(height: 20,),
        // CustomInfo(label: const Text('Racks'), subtitle: const Text('Online: 8'), icon: Image.asset('assets/images/8.gif'), button: const Text('Stock: 0'), color: const Color(0xfff9d423), funcion: () {  },)
      
      ],
    );
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
          color: Colors.blueAccent,
        ),
        labelWidget: const Text('Add Element', style: TextStyle(color: Colors.black54),),
        backgroundColor: Colors.white30,
        onTap: () {
          context.push('/add');
        },
        ),
        /*SpeedDialChild(
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
        )*/
      ],
      child: const Icon(
        Icons.menu_open_rounded,
        color: Color(0xff1648c2),
      ),
    );
  }
}