import 'package:flutter/material.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/widgets/consult/format_date.dart';

class DateSeparatorWidget extends StatelessWidget {
  final DateTime date;
  const DateSeparatorWidget({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            )
          ],
        ),
        child: Text(
          formatDate(date),
          style: h7SemiBold,
        ),
      ),
    );
  }
}
