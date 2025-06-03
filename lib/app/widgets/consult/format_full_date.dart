import 'package:temanbicara/app/widgets/consult/month_name.dart';

String formatFullDate(String date) {
  final parsed = DateTime.parse(date);
  return "${parsed.day} ${monthName(parsed.month)} ${parsed.year}";
}

DateTime parseDateWithMonthName(String dateStr) {
  try {
    final parts = dateStr.split(' ');
    final day = int.parse(parts[0]);

    final month = monthNameToNumber(parts[1]);

    final year = int.parse(parts[2]);
    final timeParts = parts[3].split(':');
    final hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);

    return DateTime(year, month, day, hour, minute);
  } catch (e) {
    print('Error parsing date: $e');
    return DateTime.now();
  }
}
