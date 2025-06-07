import 'package:intl/intl.dart';
import 'package:temanbicara/app/widgets/consult/month_name.dart';

String formatDate(DateTime dateTime) {
  return DateFormat('dd MMM yyyy').format(dateTime);
}

String convertDateToDDMMYYYY(String inputDate) {
  try {
    final date = DateTime.parse(inputDate);
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return '$day$month$year';
  } catch (e) {
    // print('Invalid date format: $e');
    return inputDate;
  }
}

String convertIndoDateToDDMMYYYY(String input) {
  try {
    final parts = input.split(' ');
    final day = parts[0].padLeft(2, '0');
    final monthNum = monthNameToNumber(parts[1]);
    final month = monthNum.toString().padLeft(2, '0');
    final year = parts[2];

    return '$day$month$year';
  } catch (e) {
    // print('Error converting date: $e');
    return input;
  }
}
