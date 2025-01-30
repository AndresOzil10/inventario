import 'package:flutter/material.dart';
import 'package:transfer_list/transfer_list.dart';

class AsignarEquipoScreen extends StatelessWidget {
  const AsignarEquipoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          backgroundColor: const Color(0xff364461),
          foregroundColor: const Color(0xffe0e4ce),  //Color de letra
          centerTitle: true,
          title: const Text("Assign Equipment"),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: TransferList(
              leftList: const ['Dog', 'Cat', 'Mouse', 'Rabbit', 'Sheep'],
              rightList: const ['Apple', 'Banana', 'Orange', 'Pineapple', 'Strawberry'],
              onChange: (leftList, rightList) {
                print('Left list: $leftList');
                print('Right list: $rightList');
              },
              checkboxFillColor: const Color(0xff364461),
              tileSplashColor: Colors.amber,
              listBackgroundColor: Colors.grey.shade200,
              textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          )
        ),
    );
  }
}