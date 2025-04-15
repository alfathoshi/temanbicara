// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:temanbicara/app/widgets/transaction/transactionTimeline.dart';

class TransactionTimeLineViewIndex extends StatelessWidget {
  final int index;
  const TransactionTimeLineViewIndex({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    List<TransactionTimeline> items;

    switch (index) {
      case 1:
        items = TransactionTimelineItems.getPage1Items(context);
        break;
      case 2:
        items = TransactionTimelineItems.getPage2Items(context);
        break;
      case 3:
        items = TransactionTimelineItems.getPage3Items(context);
        break;
      default:
        items = TransactionTimelineItems.getPage4Items(context);
        break;
    }

    return TransactionTimeLineView(items: items);
  }
}

class TransactionTimeLineView extends StatelessWidget {
  final List<TransactionTimeline> items;
  const TransactionTimeLineView({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
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
  static List<TransactionTimeline> getPage1Items(BuildContext context) {
    return [
      TransactionTimeline(
          isFirst: true,
          isLast: false,
          isPast: false,
          text: "Details",
          lineLength: MediaQuery.of(context).size.width / 4,
          isCurrent: true),
      TransactionTimeline(
          isFirst: false,
          isLast: false,
          isPast: false,
          text: "Method",
          lineLength: MediaQuery.of(context).size.width / 4,
          isCurrent: false),
      TransactionTimeline(
          isFirst: false,
          isLast: false,
          isPast: false,
          text: "Payment",
          lineLength: MediaQuery.of(context).size.width / 4,
          isCurrent: false),
      TransactionTimeline(
          isFirst: false,
          isLast: false,
          isPast: false,
          text: "Success",
          lineLength: MediaQuery.of(context).size.width / 4,
          isCurrent: false),
    ];
  }

  static List<TransactionTimeline> getPage2Items(BuildContext context) {
    return [
      TransactionTimeline(
          isFirst: true,
          isLast: false,
          isPast: true,
          text: "Details",
          lineLength: MediaQuery.of(context).size.width / 4,
          isCurrent: false),
      TransactionTimeline(
          isFirst: false,
          isLast: false,
          isPast: false,
          text: "Method",
          lineLength: MediaQuery.of(context).size.width / 4,
          isCurrent: true),
      TransactionTimeline(
          isFirst: false,
          isLast: false,
          isPast: false,
          text: "Payment",
          lineLength: MediaQuery.of(context).size.width / 4,
          isCurrent: false),
      TransactionTimeline(
          isFirst: false,
          isLast: false,
          isPast: false,
          text: "Success",
          lineLength: MediaQuery.of(context).size.width / 4,
          isCurrent: false),
    ];
  }

  static List<TransactionTimeline> getPage3Items(BuildContext context) {
    return [
      TransactionTimeline(
          isFirst: true,
          isLast: false,
          isPast: true,
          text: "Details",
          lineLength: MediaQuery.of(context).size.width / 4,
          isCurrent: false),
      TransactionTimeline(
          isFirst: false,
          isLast: false,
          isPast: true,
          text: "Method",
          lineLength: MediaQuery.of(context).size.width / 4,
          isCurrent: false),
      TransactionTimeline(
          isFirst: false,
          isLast: false,
          isPast: false,
          text: "Payment",
          lineLength: MediaQuery.of(context).size.width / 4,
          isCurrent: true),
      TransactionTimeline(
          isFirst: false,
          isLast: false,
          isPast: false,
          text: "Success",
          lineLength: MediaQuery.of(context).size.width / 4,
          isCurrent: false),
    ];
  }

  static List<TransactionTimeline> getPage4Items(BuildContext context) {
    return [
      TransactionTimeline(
          isFirst: true,
          isLast: false,
          isPast: true,
          text: "Details",
          lineLength: MediaQuery.of(context).size.width / 4,
          isCurrent: false),
      TransactionTimeline(
          isFirst: false,
          isLast: false,
          isPast: true,
          text: "Method",
          lineLength: MediaQuery.of(context).size.width / 4,
          isCurrent: false),
      TransactionTimeline(
          isFirst: false,
          isLast: false,
          isPast: true,
          text: "Payment",
          lineLength: MediaQuery.of(context).size.width / 4,
          isCurrent: false),
      TransactionTimeline(
          isFirst: false,
          isLast: false,
          isPast: true,
          text: "Success",
          lineLength: MediaQuery.of(context).size.width / 4,
          isCurrent: false),
    ];
  }
}
