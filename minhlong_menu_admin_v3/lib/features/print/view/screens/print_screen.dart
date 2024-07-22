import 'package:flutter/material.dart';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PrintScreen extends StatelessWidget {
  const PrintScreen(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: PdfPreview(
        // useActions: false,
        build: (format) => _generatePdf(format, title),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.robotoRegular();

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            // mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Text(
                "OverCooked",
                style:
                    pw.TextStyle(fontSize: 50, fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(
                "To 21 - Finom - Hiep Binh - Ha Noi",
                style: const pw.TextStyle(fontSize: 14),
              ),
              pw.SizedBox(height: 20),
              pw.Text('Phiếu Thanh Toán'.toUpperCase(),
                  style: pw.TextStyle(
                      font: font,
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Table(children: [
                pw.TableRow(children: [
                  pw.Text("Tên món", style: pw.TextStyle(font: font)),
                  pw.Text("SL", style: pw.TextStyle(font: font)),
                  pw.Text("ĐG", style: pw.TextStyle(font: font)),
                  pw.Text("T.Tiền", style: pw.TextStyle(font: font)),
                ]),
              ]),
              pw.Table(
                border: const pw.TableBorder(
                    top: pw.BorderSide(style: pw.BorderStyle.dotted),
                    bottom: pw.BorderSide(style: pw.BorderStyle.dotted)),
                children: [
                  pw.TableRow(children: [
                    pw.Text("Title", style: pw.TextStyle(font: font)),
                    pw.Text("Content", style: pw.TextStyle(font: font)),
                  ]),
                  pw.TableRow(children: [
                    pw.Text("Title", style: pw.TextStyle(font: font)),
                    pw.Text("Content", style: pw.TextStyle(font: font)),
                  ]),
                  pw.TableRow(children: [
                    pw.Text("Title", style: pw.TextStyle(font: font)),
                    pw.Text("Content", style: pw.TextStyle(font: font)),
                  ]),
                ],
              ),
              // pw.SizedBox(height: 20),
              // pw.Flexible(child: pw.FlutterLogo()),
              pw.Column(children: [
                pw.SizedBox(height: 20),
                pw.Text("Hello World", style: pw.TextStyle(font: font)),
                pw.Text("Hello World", style: pw.TextStyle(font: font)),
                pw.Text("Hello World", style: pw.TextStyle(font: font)),
                pw.Text("Hello World", style: pw.TextStyle(font: font)),
                pw.Text("Hello World", style: pw.TextStyle(font: font)),
              ])
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  pw.TableRow _buildRowData(pw.Font font) {
    return pw.TableRow(children: [
      pw.Text("Tên món", style: pw.TextStyle(font: font)),
      pw.Text("SL", style: pw.TextStyle(font: font)),
      pw.Text("ĐG", style: pw.TextStyle(font: font)),
      pw.Text("T.Tiền", style: pw.TextStyle(font: font)),
    ]);
  }
}
