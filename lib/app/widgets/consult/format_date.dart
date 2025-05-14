import 'package:intl/intl.dart';

String formatDate(DateTime dateTime) {
  return DateFormat('dd MMM yyyy').format(dateTime);
}
