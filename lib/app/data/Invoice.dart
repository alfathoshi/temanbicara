import 'package:temanbicara/app/data/Transaction.dart';

class InvoiceModel {
  final TransactionModel transaction;
  final String invoice;
  final int appTax;
  final int admTax;
  final String metodePembayaran;
  final int hargaTotal;

  InvoiceModel(
      {required this.transaction,
      required this.invoice,
      required this.appTax,
      required this.admTax,
      required this.metodePembayaran,
      required this.hargaTotal});
}
