import 'package:flutter/material.dart';

class AsignarEquipoScreen extends StatelessWidget {
  const AsignarEquipoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xff364461),
          foregroundColor: const Color(0xffe0e4ce),  //Color de letra
          centerTitle: true,
          title: const Text("Assign Equipment"),
        ),
    );
  }
}