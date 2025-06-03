import 'package:temanbicara/app/widgets/consult/month_name.dart';

String formatFullDate(String date) {
  final parsed = DateTime.parse(date);
  return "${parsed.day} ${monthName(parsed.month)} ${parsed.year}";
}

