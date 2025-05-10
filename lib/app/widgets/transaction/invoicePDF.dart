import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:temanbicara/app/data/Invoice.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/widgets/transaction/idrFormatter.dart';

class CreatePDF {
  static Future<File> createPDF({
    required String name,
    required pw.Document pdf,
  }) async {
    Directory directory;

    if (Platform.isAndroid) {
      final dirs = await getExternalStorageDirectories();
      if (dirs == null || dirs.isEmpty) {
        throw Exception('No external storage directory found');
      }
      directory = dirs.first;
    } else {
      directory = await getApplicationDocumentsDirectory();
    }

    final file = File('${directory.path}/$name');
    await file.writeAsBytes(await pdf.save());
    debugPrint('PDF saved at: ${file.path}');
    return file;
  }

  static Future<File> generatePDF(InvoiceModel invoice) async {
    final pdf = pw.Document();
    final imageBytes = await loadImageFromAssets('assets/images/logo.png');
    final image = pw.MemoryImage(imageBytes);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // HEADER
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
                      pw.Text("Order ID #dummy",
                          style: pw.TextStyle(
                              color: PdfColor(0.49019607843137253,
                                  0.5803921568627451, 0.30196078431372547),
                              fontSize: 12)),
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

              // INFORMASI PEMESAN
              pw.Container(
                padding: pw.EdgeInsets.all(8),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.grey300),
                  borderRadius: pw.BorderRadius.circular(6),
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    _infoColumn("Pemesan", "dummy"),
                    _infoColumn("Email", "dummyy"),
                    _infoColumn("No.HP", "+dummy"),
                  ],
                ),
              ),

              pw.SizedBox(height: 24),

              buildInvoiceHeaderSection(invoice),

              pw.SizedBox(height: 48),

              // TABEL
              pw.Text("Detail Pembayaran",
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 14)),
              pw.SizedBox(height: 12),

              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.grey300),
                columnWidths: {
                  0: pw.FractionColumnWidth(0.07),
                  1: pw.FractionColumnWidth(0.22),
                  2: pw.FractionColumnWidth(0.35),
                  3: pw.FractionColumnWidth(0.10),
                  4: pw.FractionColumnWidth(0.15),
                },
                children: [
                  _tableRow(["No.", "Produk", "Deskripsi", "Jumlah", "Total"],
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

              // RINGKASAN TOTAL
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      _priceLine("Subtotal", invoice.hargaTotal.toString()),
                      pw.SizedBox(height: 8),
                      _priceLine("Biaya Platform",
                          invoice.transaction.appTax.toString()),
                      pw.SizedBox(height: 8),
                      _priceLine(
                          "Biaya Admin", invoice.transaction.admTax.toString()),
                      pw.Divider(),
                      _priceLine("Total pembayaran", "harga total dummy",
                          isBold: true),
                    ],
                  )
                ],
              ),

              pw.SizedBox(height: 24),

              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("Waktu dan metode pembayaran",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Text("Total pembayaran",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("dummy - ${invoice.transaction.metode}"),
                  pw.Text("Harga total dummy",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                ],
              )
            ],
          );
        },
      ),
    );

    return await createPDF(name: 'invoice.pdf', pdf: pdf);
  }

  // Helper untuk kolom informasi
  static pw.Widget _infoColumn(String title, String value) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(title,
            style: pw.TextStyle(fontSize: 10, color: PdfColors.grey600)),
        pw.Text(value, style: pw.TextStyle(fontSize: 12)),
      ],
    );
  }

  // Helper baris tabel
  static pw.TableRow _tableRow(List<String> cells, {bool isHeader = false}) {
    return pw.TableRow(
      children: cells
          .map(
            (e) => pw.Padding(
              padding: const pw.EdgeInsets.all(6),
              child: pw.Text(
                e,
                style: pw.TextStyle(
                  fontWeight:
                      isHeader ? pw.FontWeight.bold : pw.FontWeight.normal,
                  fontSize: 10,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  // Helper untuk ringkasan harga
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
            width: 100, // lebar tetap untuk label
            child: pw.Text('$label',
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
        // Kolom kiri
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            buildDetail("Nama Psikiater", trx.namaPsikiater),
            buildDetail("Topik", trx.topik),
            buildDetail("Metode", trx.metode),
            buildDetail("Durasi", "${trx.durasi} menit"),
          ],
        ),
        // Kolom kanan
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            buildDetail("Jadwal", trx.jadwal),
            buildDetail("Waktu", trx.waktu),
            buildDetail("Harga Sesi", "Rp${trx.harga}"),
            buildDetail("Jumlah Sesi", trx.sesi.toString()),
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
