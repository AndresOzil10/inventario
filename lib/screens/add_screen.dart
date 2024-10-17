import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:inventario/screens/add_computes.dart';
import 'package:inventario/screens/add_plant_component.dart';

import 'add_complemets.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});


  @override
  State<AddScreen> createState() => _AddScreenState();

  
}

class _AddScreenState extends State<AddScreen>{
  
  //List Pages
  final AddComputer _addComputer = const AddComputer();
  final AddComplemets _addComplements = AddComplemets();
  final AddPlantComponent _addPiso = AddPlantComponent();

  Widget _showPage = const AddComputer();

  Widget _pageChooser(int page){
    switch (page) {
      case 0:
      return _addComputer;
      // ignore: dead_code
      break;
      case 1:
      return _addComplements;
      // ignore: dead_code
      break;
      case 2:
      return _addPiso;
      // ignore: dead_code
      break;
      default:
      return const Center(
        child: Text('No Page by page chooser', style: TextStyle(fontSize: 30),),
      );
    }
  }

  final int _page=0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff364461),
          foregroundColor: const Color(0xffe0e4ce),  //Color de letra
          centerTitle: true,
          title: const Text("Add New Equipment"),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: _page,
          items: const [
            Icon(Icons.computer_sharp),
            Icon(Icons.category_rounded),
            Icon(Icons.work)
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.blueAccent,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          onTap: (int tappedIndex){
            setState(() {
              _showPage = _pageChooser(tappedIndex);
            });
          },
          letIndexChange: (index) => true,
        ),
        body: Container(
          color: Colors.blueAccent,
          child: Center(
            child: _showPage,
          ),
        ),
      ),
    );
  }

}