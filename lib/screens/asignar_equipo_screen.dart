import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';


class AsignarEquipoScreen extends StatelessWidget {
  AsignarEquipoScreen({super.key});

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.transparent,
  );
  void _generatePdf() async {
    final pdf = pw.Document();
    final signatureImage = await _controller.toImage();
    final signatureBytes = await signatureImage?.toByteData(format: ImageByteFormat.png);
    final signatureData = signatureBytes!.buffer.asUint8List();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Text('Documento con firma'),
              pw.SizedBox(height: 20),
              pw.Image(pw.MemoryImage(signatureData)),
            ],
          ),
        ),
      ),
    );

    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xff364461),
          foregroundColor: const Color(0xffe0e4ce),  //Color de letra
          centerTitle: true,
          title: const Text("Assign Equipment"),
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _generatePdf,
            ),
          ],
        ),
        body: Column(
        children: [
          Expanded(
            child: Signature(
              controller: _controller,
              height: 300,
              backgroundColor: Colors.grey[200]!,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  _controller.clear();
                },
                child: const Text('Limpiar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}