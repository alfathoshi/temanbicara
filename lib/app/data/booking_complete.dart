import 'package:temanbicara/app/data/transaction_model.dart';

class BookingComplete {
  final String invoice;
  final String bookingDate;
  final TransactionModel transaction;
  final String metode;
  final String profileUrl;

  BookingComplete({
    required this.invoice,
    required this.metode,
    required this.transaction,
    required this.bookingDate,
    required this.profileUrl,
  });
}
