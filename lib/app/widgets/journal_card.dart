import 'package:flutter/material.dart';

import '../themes/colors.dart';
import '../themes/fonts.dart';

class JournalCard extends StatelessWidget {
  final String title;
  final String body;
  final String type;
  final String date;

  const JournalCard({
    Key? key,
    required this.title,
    required this.body,
    required this.type,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16,
        left: 16,
        right: 16,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: border,
          ),
        ),
        width: double.infinity,
        height: 130,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: h6SemiBold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                body,
                style: h7Regular,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 70,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.yellow,
                    ),
                    child: Center(
                      child: Text(
                        type,
                        style: h7SemiBold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                date,
                style: h7Regular,
              ),
            )
          ],
        ),
      ),
    );
  }
}
