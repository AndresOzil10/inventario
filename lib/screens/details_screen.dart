import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InfoScreen extends StatefulWidget {
  String text;
  // ignore: use_key_in_widget_constructors
  InfoScreen(this.text);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff364461),
        foregroundColor: const Color(0xffe0e4ce),  //Color de letra
        centerTitle: true,
        title: Text(widget.text),
      ),
      body: Center(
        child: FloatingActionButton(onPressed: () {
          
        },),
      ),
    );
  }
}