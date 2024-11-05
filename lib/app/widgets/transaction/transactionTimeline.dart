// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TransactionTimeline extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final String text;
  final double lineLength;
  final bool isCurrent;

  const TransactionTimeline(
      {Key? key,
      required this.isFirst,
      required this.isLast,
      required this.isPast,
      required this.text,
      required this.lineLength,
      required this.isCurrent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: lineLength,
      child: TimelineTile(
        axis: TimelineAxis.horizontal,
        isFirst: isFirst,
        isLast: isLast,
        beforeLineStyle: LineStyle(
          color: isPast || isCurrent ? primaryColor : Colors.grey,
          thickness: 1,
        ),
        indicatorStyle: IndicatorStyle(
          width: 20,
          indicator: _buildIndicator(),
          color: isPast || isCurrent ? primaryColor : Colors.grey,
        ),
        endChild: Center(
          child: Text(text, style: h7Regular.copyWith(fontSize: 9)),
        ),
        hasIndicator: true,
      ),
    );
  }

  Widget _buildIndicator() {
    if (isPast) {
      return Container(child: Image.asset("assets/icons/checkIcon.png"));
    } else if (isCurrent) {
      return LottieBuilder.asset(
        "assets/animations/onPageTransaction.json",
        width: 25,
        height: 25,
      );
    } else {
      return Icon(
        Icons.circle,
        color: Colors.grey,
        size: 23,
      );
    }
  }
}
