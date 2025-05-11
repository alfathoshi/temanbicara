import 'package:temanbicara/app/data/Transaction.dart';

class InvoiceModel {
  final TransactionModel transaction;
  final String invoice;
  final String metodePembayaran;
  final int hargaTotal;

  InvoiceModel(
      {required this.transaction,
      required this.invoice,
      required this.metodePembayaran,
      required this.hargaTotal});
}
