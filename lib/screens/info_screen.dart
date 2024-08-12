import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final String name = "MX01K02-ASE3R4T";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff364461),
        foregroundColor: const Color(0xffe0e4ce),  //Color de letra
        centerTitle: true,
        title: Text("$name Info"),
      ),
      body: Center(
        child: FloatingActionButton(onPressed: () {
          
        },),
      ),
    );
  }
}