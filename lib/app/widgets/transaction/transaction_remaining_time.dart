import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';

class TransactionRemainingTime extends StatelessWidget {
  final VoidCallback onTimerEnd;

  const TransactionRemainingTime({super.key, required this.onTimerEnd});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: error),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 25, right: 33, bottom: 20, top: 20),
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
                TimerCountdown(
                  spacerWidth: 5,
                  timeTextStyle: h7Bold.copyWith(color: error),
                  enableDescriptions: false,
                  colonsTextStyle: TextStyle(color: error),
                  format: CountDownTimerFormat.minutesSeconds,
                  endTime: DateTime.now().add(
                    const Duration(
                      // days: 0,
                      // hours: 0,
                      // minutes: 20,
                      // seconds: 0,
                      days: 0,
                      hours: 0,
                      minutes: 20,
                      seconds: 00,
                    ),
                  ),
                  onEnd: () {
                    onTimerEnd();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
