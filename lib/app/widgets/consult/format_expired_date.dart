import 'package:temanbicara/app/widgets/consult/month_name.dart';

Map<String, String> parseExpiredDate(String expiredDate) {
  if (expiredDate.isEmpty) return {"date": "-", "time": "-"};
  final parts = expiredDate.split(' ');
  if (parts.length != 2) return {"date": "-", "time": "-"};
  final parsedDate = DateTime.parse(parts[0]);
  return {
    "date": "${parsedDate.day} ${monthName(parsedDate.month)}",
    "time": parts[1].substring(0, 5)
  };
}
