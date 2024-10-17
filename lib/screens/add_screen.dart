import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:inventario/screens/add_computes.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});


  @override
  State<AddScreen> createState() => _AddScreenState();

  
}

class _AddScreenState extends State<AddScreen>{
  
  //List Pages
  final AddComputer _addComputer = AddComputer();
  //final AddComplemets _addComplements = AddComplements();
  //final AddPiso _addPiso = AddPiso();

  Widget _showPage = AddComputer();

  Widget _pageChooser(int page){
    switch (page) {
      case 0:
      return _addComputer;
      break;
      case 1:
      return const Text("Page 2");
      break;
      case 2:
      return const Text("Page 3");
      break;
      default:
      return const Center(
        child: Text('No Page by page chooser', style: TextStyle(fontSize: 30),),
      );
    }
  }

  int _page=0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

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