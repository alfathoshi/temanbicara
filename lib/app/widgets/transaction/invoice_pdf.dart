import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:temanbicara/app/data/invoice_model.dart';
import 'package:temanbicara/app/widgets/consult/format_date.dart';

class CreatePDF {
  static Future<File> generatePDF(InvoiceModel invoice,
      {String? outputPath}) async {
    final pdf = pw.Document();
    final imageBytes = await loadImageFromAssets('assets/images/logo.png');
    final image = pw.MemoryImage(imageBytes);
    final box = GetStorage();
    final email = box.read('email');
    final phone = box.read('phone');
    final name = box.read('name');

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("INVOICE",
                          style: pw.TextStyle(
                              fontSize: 40, fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: 4),
                      pw.Text(
                          "INV-${invoice.transaction.selectedID}-${convertDateToDDMMYYYY(invoice.transaction.jadwal)}",
                          style: const pw.TextStyle(
                              color: PdfColor(0.49, 0.58, 0.30), fontSize: 12)),
                    ],
                  ),
                  pw.Container(
                    width: 80,
                    height: 40,
                    alignment: pw.Alignment.center,
                    child: pw.Image(image),
                  )
                ],
              ),
              pw.SizedBox(height: 48),
              pw.Container(
                padding: const pw.EdgeInsets.all(8),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.grey300),
                  borderRadius: pw.BorderRadius.circular(6),
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    _infoColumn("Name", name),
                    _infoColumn("Email", email),
                    _infoColumn("Phone Number", phone),
                  ],
                ),
              ),
              pw.SizedBox(height: 24),
              buildInvoiceHeaderSection(invoice),
              pw.SizedBox(height: 48),
              pw.Text("Transaction Detail",
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 14)),
              pw.SizedBox(height: 12),
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.grey300),
                columnWidths: {
                  0: const pw.FractionColumnWidth(0.07),
                  1: const pw.FractionColumnWidth(0.22),
                  2: const pw.FractionColumnWidth(0.35),
                  3: const pw.FractionColumnWidth(0.10),
                  4: const pw.FractionColumnWidth(0.15),
                },
                children: [
                  _tableRow(["No.", "Product", "Description", "Qty.", "Total"],
                      isHeader: true),
                  _tableRow([
                    "1",
                    "Konsultasi",
                    "Konsultasi via Call",
                    "1",
                    "Rp. 300000"
                  ]),
                  _tableRow(["2", "Adm. TAX", "-", "1", "Rp. 1000"]),
                  _tableRow(["3", "App. TAX", "-", "1", "Rp. 15000"]),
                ],
              ),
              pw.SizedBox(height: 24),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      _priceLine(
                          "Subtotal", invoice.transaction.harga.toString()),
                      pw.SizedBox(height: 8),
                      _priceLine("Application Tax",
                          invoice.transaction.appTax.toString()),
                      pw.SizedBox(height: 8),
                      _priceLine("Administration Tax",
                          invoice.transaction.admTax.toString()),
                      pw.Divider(),
                      _priceLine("Total", invoice.hargaTotal.toString(),
                          isBold: true),
                    ],
                  )
                ],
              ),
              pw.SizedBox(height: 24),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    "Time | Payment Method",
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                      "${invoice.transaction.jadwal} ${invoice.transaction.waktu} | ${invoice.transaction.metode}"),
                ],
              )
            ],
          );
        },
      ),
    );

    final outputFile = File(outputPath ?? await _getDefaultPath());
    await outputFile.writeAsBytes(await pdf.save());
    return outputFile;
  }

  static Future<String> _getDefaultPath() async {
    final dir = await getTemporaryDirectory();
    return '${dir.path}/invoice.pdf';
  }

  static pw.Widget _infoColumn(String title, String value) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(title,
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600)),
        pw.Text(value, style: const pw.TextStyle(fontSize: 12)),
      ],
    );
  }

  static pw.TableRow _tableRow(List<String> cells, {bool isHeader = false}) {
    return pw.TableRow(
      children: cells
          .map((e) => pw.Padding(
                padding: const pw.EdgeInsets.all(6),
                child: pw.Text(
                  e,
                  style: pw.TextStyle(
                    fontWeight:
                        isHeader ? pw.FontWeight.bold : pw.FontWeight.normal,
                    fontSize: 10,
                  ),
                ),
              ))
          .toList(),
    );
  }

  static pw.Widget _priceLine(String label, String value,
      {PdfColor color = PdfColors.black, bool isBold = false}) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.SizedBox(width: 150, child: pw.Text(label)),
        pw.Text(
          value,
          style: pw.TextStyle(
              color: color,
              fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal),
        ),
      ],
    );
  }

  static pw.Widget buildInvoiceHeaderSection(InvoiceModel invoice) {
    final trx = invoice.transaction;

    pw.Widget buildDetail(String label, String value) {
      return pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
            width: 100,
            child: pw.Text(label,
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          ),
          pw.Text(': $value'),
        ],
      );
    }

    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            buildDetail("Counselor Name", trx.namaPsikiater),
            buildDetail("Topic", trx.topik),
            buildDetail("Method", trx.metode),
            buildDetail("Duration", trx.durasi),
          ],
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            buildDetail("Schedule", trx.jadwal),
            buildDetail("Time", trx.waktu),
            buildDetail("Price", "Rp${trx.harga}"),
            buildDetail("Session", trx.sesi.toString()),
          ],
        ),
      ],
    );
  }
}

Future<Uint8List> loadImageFromAssets(String path) async {
  final ByteData data = await rootBundle.load(path);
  return data.buffer.asUint8List();
}
