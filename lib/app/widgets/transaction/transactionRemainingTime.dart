import 'package:flutter/material.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';

class TransactionRemainingTime extends StatelessWidget {
  const TransactionRemainingTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: error),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.only(left: 25, right: 33, bottom: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Remaining Time",
                  style: h7Bold.copyWith(color: error),
                ),
                Text(
                  "0:14:59",
                  style: h7Bold.copyWith(color: error),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
