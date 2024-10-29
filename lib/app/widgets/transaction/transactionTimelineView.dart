// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:temanbicara/app/widgets/transaction/transactionTimeline.dart';

class TransactionTimeLineViewIndex extends StatelessWidget {
  final int index;
  const TransactionTimeLineViewIndex({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    if (index == 1)
      return TransactionTimeLineView(
          items: TransactionTimelineItems.page1Items);
    else if (index == 2) {
      return TransactionTimeLineView(
          items: TransactionTimelineItems.page2Items);
    } else if (index == 3) {
      return TransactionTimeLineView(
          items: TransactionTimelineItems.page3Items);
    } else {
      return TransactionTimeLineView(
          items: TransactionTimelineItems.page4Items);
    }
  }
}

class TransactionTimeLineView extends StatelessWidget {
  final List<TransactionTimeline> items;
  const TransactionTimeLineView({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(items.length, (index) {
          final item = items[index];
          return TransactionTimeline(
            isFirst: index == 0,
            isLast: index == items.length - 1,
            isPast: item.isPast,
            text: item.text,
            lineLength: item.lineLength,
            isCurrent: item.isCurrent,
          );
        }),
      ),
    );
  }
}

class TransactionTimelineItems {
  static List<TransactionTimeline> page1Items = [
    TransactionTimeline(
        isFirst: true,
        isLast: false,
        isPast: false,
        text: "Details",
        lineLength: 60,
        isCurrent: true),
    TransactionTimeline(
        isFirst: false,
        isLast: false,
        isPast: false,
        text: "Method",
        lineLength: 120,
        isCurrent: false),
    TransactionTimeline(
        isFirst: false,
        isLast: false,
        isPast: false,
        text: "Payment",
        lineLength: 120,
        isCurrent: false),
    TransactionTimeline(
        isFirst: false,
        isLast: false,
        isPast: false,
        text: "Success",
        lineLength: 60,
        isCurrent: false),
  ];

  static List<TransactionTimeline> page2Items = [
    TransactionTimeline(
        isFirst: true,
        isLast: false,
        isPast: true,
        text: "Details",
        lineLength: 60,
        isCurrent: false),
    TransactionTimeline(
        isFirst: false,
        isLast: false,
        isPast: false,
        text: "Method",
        lineLength: 120,
        isCurrent: true),
    TransactionTimeline(
        isFirst: false,
        isLast: false,
        isPast: false,
        text: "Payment",
        lineLength: 120,
        isCurrent: false),
    TransactionTimeline(
        isFirst: false,
        isLast: false,
        isPast: false,
        text: "Success",
        lineLength: 60,
        isCurrent: false),
  ];

  static List<TransactionTimeline> page3Items = [
    TransactionTimeline(
        isFirst: true,
        isLast: false,
        isPast: true,
        text: "Details",
        lineLength: 60,
        isCurrent: false),
    TransactionTimeline(
        isFirst: false,
        isLast: false,
        isPast: true,
        text: "Method",
        lineLength: 120,
        isCurrent: false),
    TransactionTimeline(
        isFirst: false,
        isLast: false,
        isPast: false,
        text: "Payment",
        lineLength: 120,
        isCurrent: true),
    TransactionTimeline(
        isFirst: false,
        isLast: false,
        isPast: false,
        text: "Success",
        lineLength: 60,
        isCurrent: false),
  ];

  static List<TransactionTimeline> page4Items = [
    TransactionTimeline(
        isFirst: true,
        isLast: false,
        isPast: true,
        text: "Details",
        lineLength: 60,
        isCurrent: false),
    TransactionTimeline(
        isFirst: false,
        isLast: false,
        isPast: true,
        text: "Method",
        lineLength: 120,
        isCurrent: false),
    TransactionTimeline(
        isFirst: false,
        isLast: false,
        isPast: true,
        text: "Payment",
        lineLength: 120,
        isCurrent: false),
    TransactionTimeline(
        isFirst: false,
        isLast: false,
        isPast: false,
        text: "Success",
        lineLength: 60,
        isCurrent: true),
  ];
}
