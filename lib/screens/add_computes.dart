import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:inventario/widgets/data_time.dart';

import '../widgets/custom_text_form.dart';

class AddComputer extends StatefulWidget {

  @override
  State<AddComputer> createState() => _AddComputerState();
}

class _AddComputerState extends State<AddComputer> {
  Future<void> _selectdate() async {
    DateTime? picked = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(),
      firstDate: DateTime(2017), 
      lastDate: DateTime(30000));

    if(picked != null ){
      setState(() {
        datePicked.text = picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> _selectFinal() async {
    DateTime? pick = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(),
      firstDate: DateTime(2017), 
      lastDate: DateTime(30000));

    if(pick != null ){
      setState(() {
        dateFinal.text = pick.toString().split(" ")[0];
      });
    }
  }

  final datePicked = TextEditingController();

  final dateFinal = TextEditingController();

  final serialNumber = TextEditingController();

  final inicioEquipo = TextEditingController();

  Future<void> scanBarcodeNormal() async{
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.BARCODE);
      debugPrint(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = "Failed to get plataform version";
    }
    if(!mounted) return;
    setState(() {
      serialNumber.text = barcodeScanRes;
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Form(
          child: Column(
            children: [
              const SizedBox(
                      height: 40,
                    ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 80),
                child: Text('a')
              ),
              const SizedBox(
                      height: 40,
                    ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child:
                  TextFormFields(
                    controller: serialNumber,
                    hint: '24NR824', 
                    labelText: 'Servi Tag', 
                    icono: const Icon(Icons.computer), 
                    validators: (value){
                      return;
                    },
                    suffixIcon: IconButton(onPressed: scanBarcodeNormal, icon: const Icon(Icons.camera_alt_rounded),),
                    ),
            ),
            const SizedBox(
                      height: 25,
                    ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child:
                  DataTime(
                    controller: datePicked, 
                    labelText: 'Fecha Inicio Equipo', 
                    prefixIcon: const Icon(Icons.calendar_month), 
                    onTap: () { 
                      FocusManager.instance.primaryFocus?.unfocus();
                      _selectdate(); 
                      },
                  )
              ),
              const SizedBox(
                      height: 25,
                    ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child:
                  DataTime(
                    controller: dateFinal, 
                    labelText: 'Fecha Final Garantia', 
                    prefixIcon: const Icon(Icons.calendar_month), 
                    onTap: () { 
                      FocusManager.instance.primaryFocus?.unfocus();
                      _selectFinal(); 
                      },
                  )
              ),
            ]
          ),
        ),
      ),
    );
  }
}