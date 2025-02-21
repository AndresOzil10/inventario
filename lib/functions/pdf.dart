import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:signature/signature.dart';

final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.transparent,
  );

  void firma(String name, String serial, dynamic context) async {
    showDialog(context: context, builder: (context) => Column(
      children:[ Padding(   
        padding: const EdgeInsets.all(8.0),
        child: Signature(
          controller: _controller,
          height: 300,
          backgroundColor: Colors.grey[200]!,
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(
            onPressed: () {
              _controller.clear();
            },
            icon: const Icon(Icons.clear), label: const Text('Clear'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              generatePdf(name, serial);
            },
            icon: const Icon(Icons.save), label: const Text('Save'),
          ),
        ],
      ),
      ]
    ));
  }

void generatePdf(String name, String serial) async {
  final pdf = pw.Document();
  
  // Captura la imagen de la firma
  final signatureImage = await _controller.toImage();
  final signatureBytes = await signatureImage?.toByteData(format: ImageByteFormat.png);
  final signatureData = signatureBytes!.buffer.asUint8List();

  // Cargar la imagen del logo desde assets
  final logoImage = (await rootBundle.load('assets/images/logo1.png')).buffer.asUint8List();

  // Agregar una página al documento PDF
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Container(
        padding: const pw.EdgeInsets.all(20),
        child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
              pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
              pw.Text(
                'Kayser Automotive Systems',
                style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 16,
                ),
              ),
              pw.Text(
                'Representantes Legales',
                style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 12,
                ),
              ),
              pw.Text(
                'Presentes',
                style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 12,
                ),
              ),
              ],
              ),
              // Imagen del logo
              pw.Image(
              pw.MemoryImage(logoImage),
              width: 50,
              height: 50,
              ),
              ],
            ),
            pw.SizedBox(height: 10),
            pw.Text('Estimados Señores'),
            pw.SizedBox(height: 10),
            pw.Text(
              'El que suscribe $name manifiesto haber recibido el equipo y accesorios descritos en las responsivas adjuntas, que forman parte integral de este documento, en adelante el ´Equipo de Computo S/N: $serial´',
              style: const pw.TextStyle(fontSize: 12),
              textAlign: pw.TextAlign.justify,
            ),
            pw.SizedBox(height: 10),
            pw.Text('El equipo de Cómputo mencionado en el párrafo anterior es propiedad de Kayser Automotive Systems, por lo que por éste medio me obligo a darle un uso adecuado, cuidarlo, devolverlo en buen estado, salvo el desgaste natural de su uso, al momento de terminar mi relación laboral con la Empresa o en el momento en que la Empresa requiera su devolución.', style: const pw.TextStyle(fontSize: 12),
            textAlign: pw.TextAlign.justify,),
            pw.SizedBox(height: 10),
            pw.Text('En caso de no devolverlos en tiempo y forma indicado por Kayser Automotive Systems me obligo en los términos siguientes:', style: const pw.TextStyle(fontSize: 12),
            textAlign: pw.TextAlign.justify),
            pw.SizedBox(height: 10),
            pw.Text('--------------------------------------------------------------------------------------------------------------'),
            pw.SizedBox(height: 10),
            pw.Center(
              child: pw.Text(
              'PAGARÉ',
              style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 12,
              ),
              textAlign: pw.TextAlign.center,
              ),
            ),
            pw.SizedBox(height: 10),
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Text(
              'Puebla, Puebla a ${DateTime.now().day} de ${[
              'enero',
              'febrero',
              'marzo',
              'abril',
              'mayo',
              'junio',
              'julio',
              'agosto',
              'septiembre',
              'octubre',
              'noviembre',
              'diciembre'
              ][DateTime.now().month - 1]} de ${DateTime.now().year}',
              ),
            ),
            pw.SizedBox(height: 10),
            pw.Text('$name, a través de este pagaré me obligo a pagar incondicionalmente a la orden de Kayser Automotive Systems en su domicilio ubicado en Río Papaloapan No.27, San Lorenzo Almecatla, C.P. 72710, Puebla, Puebla, la suma de \$788.00 (); pagadero a la vista, de acuerdo al tipo de cambio vigente a la fecha, publicado por el Banco de México en el Diario Oficial de la Federación.', style: const pw.TextStyle(fontSize: 12),
            textAlign: pw.TextAlign.justify,),
            pw.SizedBox(height: 10),
            pw.Text('Acepto que, de incumplir en realizar el pago por la suma principal aquí descrita, me obligo a pagar un interés moratorio correspondiente a una tasa de interés igual a la tasa resultante de multiplicar por 1.5 (uno punto cinco) la Tasa de Interés Interbancaria de Equilibrio (T.I.I.E) vigente a la fecha de recuperación de la suma adeudada. Estos intereses moratorios se computarán a partir de la fecha en que ocurra el incumplimiento en el pago y por todo el tiempo que continúe el mismo y, en su caso, antes y después de que dicho pago sea demandado, hasta éste sea pagado. Los intereses moratorios se calcularán sobre la base de un año de trescientos sesenta Dias Naturales y por el número de Días Naturales transcurridos. Kayser Automotive Systems se reserva el derecho de ejercitar las acciones que en derecho le corresponderan para ejecutar el cobro de la suma principal, mas los intereses aplicables.', style: const pw.TextStyle(fontSize: 12),
            textAlign: pw.TextAlign.justify,),
            pw.SizedBox(height: 30),
            pw.Center(
              child: pw.Text(
              'Nombre y firma de quien Suscribe',
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 12,
              ),
              textAlign: pw.TextAlign.center,
              ),
            ),
            pw.Center(
              child: pw.Image(pw.MemoryImage(signatureData), width: 50, height: 50),
            ),
            pw.Center(
              child: pw.Text('______________________________________________'),
            ),
            pw.Center(
              child: pw.Text(name)
            )
          ],
        ),
      ),
    ),
  );
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Container(
        padding: const pw.EdgeInsets.all(20),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
           pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Constancia de entrega',
                    style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 16,
                    ),
                  ),
                  pw.Text(
                    '(Hardware y Software)',
                    style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 12,
                    ),
                  ),
                ],
              ),
              pw.Image(
              pw.MemoryImage(logoImage),
              width: 50,
              height: 50,
              ),
              ],
              
            ),
          ],
        ),
      ),
    ),
  );

  // Imprimir el PDF
  await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
}