import 'package:flutter/material.dart';
import 'package:temanbicara/app/themes/fonts.dart';

import '../themes/colors.dart';

class MyJournal extends StatelessWidget {
  const MyJournal(
      {super.key,
      required this.type,
      required this.title,
      required this.date,
      required this.colors});
  final String type;
  final String title;
  final String date;
  final Color colors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Container(
        decoration: BoxDecoration(
            color: whiteColor,
            border: Border.all(
              color: Colors.black26,
            ),
            borderRadius: BorderRadius.circular(16)),
        width: 150,
        height: 141,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 79,
                height: 21,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: colors,
                ),
                child: Center(
                  child: Text(
                    type,
                    style: h7SemiBold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 8),
                child: SizedBox(
                  child: Text(
                    title,
                    style: h4SemiBold,
                  ),
                ),
              ),
              Text(
                date,
                style: h7Regular,
              )
            ],
          ),
        ),
      ),
    );
  }
}
